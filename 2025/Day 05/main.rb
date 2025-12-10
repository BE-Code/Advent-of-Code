def solvePart1(input, verbose)
  ranges = []
  for range in input[0]
    ranges.push(range.split("-").map(&:to_i))
  end
  ingredients = input[1].map(&:to_i)
  answer = 0
  ingredients.each do |ingredient|
    for range in ranges
      if ingredient >= range[0] && ingredient <= range[1]
        answer += 1
        break
      end
    end
  end
  return answer
end

def solvePart2(lines, verbose)
  answer = 0
  lines.each do |line|
    # puts line
    answer += 1
  end
  return answer
end
