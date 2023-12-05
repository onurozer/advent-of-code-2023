DATA = File.readlines("day_2_input.txt")

# Part 1
possible_games = []

MAX_VALUES = {
  "red" => 12,
  "green" => 13,
  "blue" => 14
}

DATA.each do |line|
  # split id and game
  game_id, game_results = line.split(": ")
  id = game_id.split(" ").last.to_i

  # split sets
  sets = game_results.split("; ")

  results_possibility = []
  # iterate through sets and determine if the game
  sets.each do |set_results|
    set_results.split(", ").each do |combo|
      count, color = combo.split(" ")
      results_possibility << (count.to_i <= MAX_VALUES[color])
    end
  end
  possible_games << id unless results_possibility.include? false
end
puts "Part1: #{possible_games.sum}"

# Part 2
grand_total = 0

DATA.each do |line|
  highest_values = {
    "red" => 0,
    "green" => 0,
    "blue" => 0
  }
  line.split(": ").last.split("; ").map do |sets|
    sets.split(", ").map do |set|
      a = set.split(" ").reverse
      # convert to integers
      h = Hash[*a].transform_values { |v| v.to_i }
      # find and assign the highest value in each game
      h.each { |k, v| highest_values[k] = v if highest_values[k] < v }
    end
  end
  # calculate power and assign it to the grand total
  grand_total += highest_values.values.reduce(1) { |result, value| (result * value) }
end
puts "Part2: #{grand_total}"
