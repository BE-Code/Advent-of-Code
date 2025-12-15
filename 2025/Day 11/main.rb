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

def numPathsToOutput2(start, links, endNode = "out", visitedDAC = false, visitedFFT = false, visitedNodes = [])
  visitedNodes.push(start)
  if start == "dac" then visitedDAC = true end
  if start == "fft" then visitedFFT = true end
  if links[start].include?("out")
    return (visitedDAC && visitedFFT) ? 1 : 0
  end
  pathsFound = 0
  for dest in links[start]
    if visitedNodes.include?(dest)
      puts("found loop", visitedNodes.to_json(), "next dest: #{dest}")
      next
    end
    pathsFound += numPathsToOutput2(dest, links, endNode, visitedDAC, visitedFFT, visitedNodes.clone())
  end
  return pathsFound
end

# Unfinished
def solvePart2(lines)
  # puts(lines.to_json())
  links = {}
  for line in lines
    links[line[0][0]] = line[1]
  end
  # puts(links.to_json())

  fftToDac = numPathsToOutput2("fft", links, "dac", true, true)
  puts("fftToDac: #{fftToDac}")
  fftToDac *= numPathsToOutput2("dac", links, "out", true, true)
  puts("dacToOut: #{fftToDac}")

  # dacToFft = numPathsToOutput2("dac", links, "fft", true, true)
  # dacToFft *= numPathsToOutput2("fft", links, "out", true, true)
  # puts("dacToFft: #{dacToFft}")

  # numPaths = numPathsToOutput2("svr", links)
  return numPaths
end
