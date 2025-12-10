def findBiggestNumberIndex(nString)
  biggestIndex = 0
  for i in 1..nString.length - 1
    if nString[i].to_i > nString[biggestIndex].to_i
      biggestIndex = i
    end
  end
  return biggestIndex
end

def solvePart1(lines, verbose)
  answer = 0
  lines.each do |line|
    biggestIndex = findBiggestNumberIndex(line[0..-2])
    secondBiggestIndex = findBiggestNumberIndex(line[biggestIndex + 1..-1]) + biggestIndex.to_i + 1
    (verbose) ? puts("biggestIndex: #{biggestIndex}, secondBiggestIndex: #{secondBiggestIndex}") : nil
    answer += (line[biggestIndex] + line[secondBiggestIndex]).to_i
  end
  return answer
end

def solvePart2(lines, verbose)
  answer = 0
  lines.each do |line|
    maxNumber = ""
    offset = 0
    for i in 12.downto(1)
      biggestIndex = findBiggestNumberIndex(line[offset..-i]) + offset
      offset = biggestIndex.to_i + 1
      (verbose) ? puts("biggestIndex: #{biggestIndex}, offset: #{offset}") : nil
      maxNumber += line[biggestIndex]
    end
    (verbose) ? puts("maxNumber: #{maxNumber}") : nil
    answer += maxNumber.to_i
  end
  return answer
end
