def parseBinaryOutcomes(lines)
  lines.map { |line|
    outcome = line[0]
    outcomeValue = 0
    for c in 0..outcome.length - 2
      if outcome[c + 1] == "#"
        outcomeValue += 1 << c
      end
    end
    outcomeValue
  }
end

def buttonToBinary(button)
  nums = button[1..-2].split(",").map(&:to_i)
  binaryNum = 0
  for i in 0..nums.length - 1
    binaryNum += 1 << nums[i]
  end
  binaryNum
end

def parseBinaryButtons(lines)
  lines.map { |line|
    buttons = []
    for b in line[1..-2]
      buttons.push(buttonToBinary(b))
    end
    buttons
  }
end

def combinationResult(combination)
  binaryNum = 0
  for button in combination
    binaryNum ^= button
  end
  binaryNum
end

def getMinimumButtonPresses(outcome, buttons)
  for i in 0..buttons.length - 1
    combinations = buttons.combination(i + 1).to_a
    for combination in combinations
      if combinationResult(combination) == outcome
        puts(combination.to_json())
        return combination
      end
    end
  end
  puts("No valid combination found")
  exit(1)
end

def solvePart1(lines)
  binaryOutcomes = parseBinaryOutcomes(lines)
  binaryButtons = parseBinaryButtons(lines)
  # puts(binaryOutcomes.to_json())
  # puts(binaryButtons.to_json())
  answer = 0
  for i in 0..binaryOutcomes.length - 1
    answer += getMinimumButtonPresses(binaryOutcomes[i], binaryButtons[i]).length
  end
  return answer
end

def solvePart2(lines)
  puts(lines.to_json())

  answer = 0
  lines.each do |line|
    answer += 1
  end
  return answer
end
