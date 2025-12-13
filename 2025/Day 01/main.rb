def solvePart1(lines, verbose = true)
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

def solvePart2(lines, verbose = true)
  answer = 0
  dialPosition = 50
  nDialPositions = 100
  lines.each do |line|
    isNegative = line.start_with?("L")
    quantity = line[1..-1].to_i
    twistAmt = isNegative ? quantity * -1 : quantity
    oldDialPosition = dialPosition
    oldAnswer = answer
    dialPosition += twistAmt
    if dialPosition < 0
      nFullTurns = (dialPosition / nDialPositions.to_f).ceil
      answer += nFullTurns.abs
      if oldDialPosition > 0
        answer += 1
      end
    elsif dialPosition > 0
      nFullTurns = dialPosition / nDialPositions
      answer += nFullTurns
    else
      answer += 1
    end
    dialPosition %= nDialPositions
    if verbose
      puts "#{oldDialPosition} -(#{twistAmt})-> #{dialPosition} = #{answer - oldAnswer}"
    end
  end
  return answer
end


# Types of 0 crossings:
# - land on 0
# - cross while turning left
#   - result will always be negative
#   - answer will be increased by at least 1 and more based on integer division
# - cross while turning right
#   - integer division alone will tell you the increase