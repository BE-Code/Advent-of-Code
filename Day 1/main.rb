
def solvePart1(lines, testMode)
  answer = 0
  dialPosition = 50
  nDialPositions = 100
  lines.each do |line|
    isNegative = line.start_with?("L")
    quantity = line[1..-1].to_i
    twistAmt = isNegative ? quantity * -1 : quantity
    dialPosition += twistAmt
    dialPosition %= nDialPositions
    if dialPosition == 0
      answer += 1
    end
  end
  return answer
end

def solvePart2(lines, testMode)
  answer = 0
  lines.each do |line|
    # puts line
    answer += 1
  end
  return answer
end
