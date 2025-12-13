def area(coord1, coord2)
  return ((coord1[0].to_i - coord2[0].to_i).abs + 1) * ((coord1[1].to_i - coord2[1].to_i).abs + 1)
end

def findAreas(coords)
  areas = []
  for i in 0..coords.length - 1
    for j in i + 1..coords.length - 1
      areas.push([[i, j], area(coords[i], coords[j])])
    end
  end
  return areas
end

def solvePart1(lines)
  areas = findAreas(lines)
  sortedAreas = areas.sort_by { |area| area[1] }.reverse

  printAreas = sortedAreas.map { |area| area[1] }
  puts(printAreas.to_json())

  return sortedAreas[0][1]
end

def solvePart2(lines)
  puts(lines.to_json())

  answer = 0
  lines.each do |line|
    answer += 1
  end
  return answer
end
