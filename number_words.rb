$underTwentyWords = {
  19 => "Nineteen",
  18 => "Eighteen",
  17 => "Seventeen",
  16 => "Sixteen",
  15 => "Fifteen",
  14 => "Fourteen",
  13 => "Thirteen",
  12 => "Twelve",
  11 => "Eleven",
  10 => "Ten",
  9  => "Nine",
  8  => "Eight",
  7  => "Seven",
  6  => "Six",
  5  => "Five",
  4  => "Four",
  3  => "Three",
  2  => "Two",
  1  => "One"}

$decadeWords = {
  2 => "Twenty",
  3 => "Thirty",
  4 => "Fourty",
  5 => "Fifty",
  6 => "Sixty",
  7 => "Seventy",
  8 => "Eighty",
  9 => "Ninety"}

$placeValueWords = {
  1000       => "Thousand",
  1000000    => "Million",
  1000000000 => "Billion"}

$digitGroupValues = (0 .. $placeValueWords.length).map{|n| (10 ** (3 * n))}

def overTwentyWords(n)
  tens = (n / 10).floor % 10
  remainder = n % 10
  tensStr = $decadeWords[tens]
  remainderStr = $underTwentyWords[remainder]
  if tensStr and remainderStr
    tensStr + "-" + remainderStr
  else
    tensStr or remainderStr
  end
end

def digitGroupWords(n)
  hundreds = n / 100
  remainder = n % 100
  hundredsStr =
    if hundreds > 0
      $underTwentyWords[hundreds] + " Hundred"
    end
  remainderStr = 
    if remainder > 0
      if remainder < 20
        $underTwentyWords[remainder]
      else
        overTwentyWords(remainder)
      end
    end
  if hundredsStr and remainderStr
    hundredsStr + " and " + remainderStr
  else
    hundredsStr or remainderStr
  end
end

def digitGroup(n, group)
  (n / group) % 1000
end

def digitGroupStr(n, group)
  digits = digitGroup(n, group)
  digitsStr = digitGroupWords(digits)
  placeStr = $placeValueWords[group]
  if digitsStr and placeStr
    digitsStr + " " + placeStr
  else
    digitsStr
  end
end

def numberWordSeq(n)
  $digitGroupValues.take_while{|v| n >= v}.reverse.map{|g| digitGroupStr(n, g)}
end

def numberWords(n)
  if n == 0
    "Zero"
  elsif n < 0
    "Negative " + numberWords(-1 * n)
  else
    numberWordSeq(n).join(", ")
  end
end

def tests()
  numberWords(4331434344) == "Four Billion, Three Hundred and Thirty-One Million, Four Hundred and Thirty-Four Thousand, Three Hundred and Fourty-Four" and
  numberWords(86435497) == "Eighty-Six Million, Four Hundred and Thirty-Five Thousand, Four Hundred and Ninety-Seven" and
  numberWords(4534) == "Four Thousand, Five Hundred and Thirty-Four" and
  numberWords(1243) == "One Thousand, Two Hundred and Fourty-Three" and
  numberWords(934) == "Nine Hundred and Thirty-Four" and
  numberWords(423) == "Four Hundred and Twenty-Three" and
  numberWords(123) == "One Hundred and Twenty-Three" and
  numberWords(89) == "Eighty-Nine" and
  numberWords(32) == "Thirty-Two" and
  numberWords(7) == "Seven" and
  numberWords(0) == "Zero" and
  numberWords(-3456) == "Negative Three Thousand, Four Hundred and Fifty-Six"
end

print(if tests() then "Success" else "Failure" end, "\n")
