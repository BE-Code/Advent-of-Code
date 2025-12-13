def distance(box1, box2)
  return Math.sqrt((box1[0].to_i - box2[0].to_i)**2 + (box1[1].to_i - box2[1].to_i)**2 + (box1[2].to_i - box2[2].to_i)**2)
end

def findBoxDistances(boxes)
  boxDistances = []
  for i in 0..boxes.length - 1
    for j in i + 1..boxes.length - 1
      boxDistances.push([[i, j], distance(boxes[i], boxes[j])])
    end
  end
  return boxDistances
end

def getGroupIndex(boxIndex, groups)
  for i in 0..groups.length - 1
    if groups[i].include?(boxIndex)
      return i
    end
  end
  return nil
end

def solvePart1(boxes)
  nConnections = boxes.length <= 20 ? 10 : 1000
  puts(boxes.length)
  groups = []
  boxDistances = findBoxDistances(boxes)
  puts(boxDistances.length)
  sortedBoxDistances = boxDistances.sort_by { |boxDistance| boxDistance[1] }

  printBoxDistances = sortedBoxDistances.map { |boxDistance| boxDistance[0] }[0..nConnections - 1]
  puts(printBoxDistances.to_json())
  for i in 0..nConnections - 1
    newConnection = sortedBoxDistances[i][0]
    groupA = getGroupIndex(newConnection[0], groups)
    groupB = getGroupIndex(newConnection[1], groups)
    if groupA == nil && groupB == nil
      groups.push([newConnection[0], newConnection[1]])
    elsif groupA == nil
      groups[groupB].push(newConnection[0])
    elsif groupB == nil
      groups[groupA].push(newConnection[1])
    elsif groupA != groupB
      groups[groupA] = Set.new(groups[groupA] + groups[groupB]).to_a
      groups.delete_at(groupB)
    end
    # puts(groups.to_json() + " " + newConnection.to_json())
  end
  sortedGroups = groups.sort_by { |group| group.length }.reverse
  # puts("==========")
  # puts(sortedGroups.to_json())
  return sortedGroups[0].length * sortedGroups[1].length * sortedGroups[2].length
end

def solvePart2(boxes)
  nConnections = boxes.length <= 20 ? 10 : 1000
  puts(boxes.length)
  groups = []
  boxDistances = findBoxDistances(boxes)
  puts(boxDistances.length)
  sortedBoxDistances = boxDistances.sort_by { |boxDistance| boxDistance[1] }

  printBoxDistances = sortedBoxDistances.map { |boxDistance| boxDistance[0] }[0..nConnections - 1]
  puts(printBoxDistances.to_json())
  for i in 0..nConnections - 1
    newConnection = sortedBoxDistances[i][0]
    groupA = getGroupIndex(newConnection[0], groups)
    groupB = getGroupIndex(newConnection[1], groups)
    if groupA == nil && groupB == nil
      groups.push([newConnection[0], newConnection[1]])
    elsif groupA == nil
      groups[groupB].push(newConnection[0])
    elsif groupB == nil
      groups[groupA].push(newConnection[1])
    elsif groupA != groupB
      groups[groupA] = Set.new(groups[groupA] + groups[groupB]).to_a
      groups.delete_at(groupB)
    end
    # puts(groups.to_json() + " " + newConnection.to_json())
  end
  sortedGroups = groups.sort_by { |group| group.length }.reverse
  # puts("==========")
  # puts(sortedGroups.to_json())
  return sortedGroups[0].length * sortedGroups[1].length * sortedGroups[2].length
end
