# Don't forget to chomp to remove the \n from the end of the line!
lines = File.readlines("day_3_input.txt").map(&:chomp)

# Part 1
characters = lines.map { |l| l.chars }
max_rows = characters.length - 1
max_cols = characters.first.length - 1

matches = []

lines.each_with_index do |line, row|
  # search for numbers in each line
  line.scan(/\d+/) {
    # not a valid part yet
    part_number = false

    # capture the number and assess
    match = Regexp.last_match
    col = match.begin(0)
    size = match.to_s.size

    # calculate search space
    start_row = [0, row - 1].max
    start_col = [0, col - 1].max
    end_row = [max_rows, row + 1].min
    end_col = [max_cols, (col + size)].min

    # search for adjacent characters for a symbol
    start_row.upto(end_row) do |r|
      start_col.upto(end_col) do |c|
        # if you find a symbol
        if !characters[r][c].scan(/[\W&&[^.]]/).empty?
          part_number = true
          break
        end
      end
      if part_number == true
        matches << match.to_s.to_i
        break
      end
    end
  }
end

puts "Part 1: #{matches.sum} "

# Part 2

characters = lines.map { |l| l.chars }
max_rows = characters.length - 1
max_cols = characters.first.length - 1

matches = []

lines.each_with_index do |line, row|
  # search for * in each line
  line.scan(/[*]/) {
    match = Regexp.last_match
    col = match.begin(0)

    # calculate search space
    start_row = [0, row - 1].max
    end_row = [max_rows, row + 1].min
    start_col = [0, col - 1].max
    end_col = [max_cols, col + 1].min

    # search for adjacent characters for a number, temporarily store it
    temporary_parts = []

    start_row.upto(end_row) do |r|
      # match all the numbers in the search rows
      lines[r].scan(/\d+/) {
        match = Regexp.last_match
        match_start = match.begin(0)
        match_end = match_start + match.to_s.size - 1
        # check if the number starts or ends within the search space
        if match_start.between?(start_col, end_col) || match_end.between?(start_col, end_col)
          temporary_parts << match.to_s.to_i
        end
      }
    end
    # if there are two numbers, multiply them and add to matches
    if temporary_parts.length == 2
      gear_ratio = temporary_parts.inject(:*)
      matches << gear_ratio
    end
  }
end

puts "Part 2: #{matches.sum} "
