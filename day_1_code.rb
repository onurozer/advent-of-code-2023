DATA = File.readlines("day_1_input.txt")

# Part 1
values = DATA.map do |line|
  numbers = line.scan(/\d/)
  (numbers.first + numbers.last).to_i
end

puts "Part 1: #{values.sum}"

# Part 2
digits = {
  "one" => 1,
  "two" => 2,
  "three" => 3,
  "four" => 4,
  "five" => 5,
  "six" => 6,
  "seven" => 7,
  "eight" => 8,
  "nine" => 9
}

# The (?=...) is a positive lookahead. It asserts that what immediately
# follows the current position in the string must match the pattern inside
# the parentheses, but it doesn't consume any characters. In other words,
# it checks if a certain pattern is there without moving the regex engine's
# current position.

# Example: regex matches both "one" and "eight" in "zoneight234"

regex = /(?=(one|two|three|four|five|six|seven|eight|nine|\d))/

values = DATA.map do |line|
  matches = line.scan(regex).flatten
  first = digits.fetch(matches.first, matches.first)
  last = digits.fetch(matches.last, matches.last)
  "#{first}#{last}".to_i
end

puts "Part 2: #{values.sum}"
