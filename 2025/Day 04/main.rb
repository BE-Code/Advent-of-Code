def solvePart1(lines, verbose)
  answer = 0
  for i in 0..lines[0].length - 1
    for j in 0..lines[i].length - 1
      if lines[i][j] == "."
        next
      end
      adjacentRolls = 0
      if j > 0 && lines[i][j] == lines[i][j - 1]
        adjacentRolls += 1
      end
      if j < lines[i].length - 1 && lines[i][j] == lines[i][j + 1]
        adjacentRolls += 1
      end
      if i > 0 && lines[i][j] == lines[i - 1][j]
        adjacentRolls += 1
      end
      if i < lines.length - 1 && lines[i][j] == lines[i + 1][j]
        adjacentRolls += 1
      end

      # diagonals
      if i > 0 && j > 0 && lines[i][j] == lines[i - 1][j - 1]
        adjacentRolls += 1
      end
      if i > 0 && j < lines[i].length - 1 && lines[i][j] == lines[i - 1][j + 1]
        adjacentRolls += 1
      end
      if i < lines.length - 1 && j > 0 && lines[i][j] == lines[i + 1][j - 1]
        adjacentRolls += 1
      end
      if i < lines.length - 1 && j < lines[i].length - 1 && lines[i][j] == lines[i + 1][j + 1]
        adjacentRolls += 1
      end
      if adjacentRolls < 4
        answer += 1
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
