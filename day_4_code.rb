# Part 1
example = 'Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11'

# lines = example.squeeze(" ").split("\n").map(&:chomp)
lines = File.readlines("day_4_input.txt").map { |line| line.squeeze(" ").chomp }

grand_total = 0

lines.each do |line|
  numbers = line.split(": ").last
  winners, all = numbers.split(" | ").map { |x| x.split(" ").map { |x| x.to_i } }
  winning_numbers = winners.select { |x| all.include? x }
  points = winning_numbers.empty? ? 0 : 2**(winning_numbers.length - 1)
  grand_total += points
end

puts "Part 1: #{grand_total}"

# Part 2
card_counts = Hash.new { |h, k| h[k] = 1 } # this block will be executed everytime we encounter a new key in this hash

lines.each_with_index do |line, index|
  card, numbers = line.split(": ")
  id = card.split(" ").last.to_i
  winners, all = numbers.split(" | ").map { |x| x.split(" ").map { |x| x.to_i } }
  winning_count = (winners & all).length
  card_counts[id].times do
    winning_count.times do |i|
      card_counts[id + i + 1] += 1
    end
  end
end

grand_total = card_counts.values.sum

puts "Part 2: #{grand_total}"
