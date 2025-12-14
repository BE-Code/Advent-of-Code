def numPathsToOutput(start, links)
  if links[start].include?("out") then return 1 end
  pathsFound = 0
  for dest in links[start]
    pathsFound += numPathsToOutput(dest, links)
  end
  return pathsFound
end

def solvePart1(lines)
  # puts(lines.to_json())
  links = {}
  for line in lines
    links[line[0][0]] = line[1]
  end
  # puts(links.to_json())

  numPaths = numPathsToOutput("you", links)
  return numPaths
end

def solvePart2(lines)
  puts(lines.to_json())

  answer = 0
  lines.each do |line|
    answer += 1
  end
  return answer
end
