def solvePart1(input, verbose = true)
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

def solvePart2(input, verbose = true)
  ranges = []
  for range in input[0]
    ranges.push(range.split("-").map(&:to_i))
  end
  sortedRanges = ranges.sort_by { |range| [range[0], range[1]] }
  (verbose) ? puts(sortedRanges.to_json()) : nil
  previousRange = [-2, -1]
  answer = 0
  previousAnswer = 0
  for range in sortedRanges
    if verbose
      puts("added #{answer - previousAnswer}")
      previousAnswer = answer
    end
    if range[1] <= previousRange[1]
      next
    end
    if range[0] > previousRange[1]
      answer += range[1] - range[0] + 1
    else
      answer += range[1] - previousRange[1]
    end
    previousRange = range
  end
  return answer
end
