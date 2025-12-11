def solvePart1(lines, verbose)
  # (verbose) ? puts(lines.to_json()) : nil
  answer = 0
  operators = lines[-1].split(" ")
  numbers = lines[0..-2].map(&:split)
  nColumns = operators.length
  for i in 0..nColumns - 1
    total = 0
    for j in 0..numbers.length - 1
      val = numbers[j][i].to_i
      # (verbose) ? puts("val: #{val}") : nil
      if total == 0
        total = val
      elsif operators[i] == "+"
        total += val
      else
        total *= val
      end
    end
    if verbose
      # puts("total: #{total}")
    end
    answer += total
  end
  return answer
end

def solvePart2(lines, verbose)
  (verbose) ? puts(lines.to_json()) : nil
  answer = 0
  operators = lines[-1].split(" ")
  numbers = lines[0..-2].map(&:split)
  nColumns = operators.length
  for i in 0..nColumns - 1
    total = 0
    for j in 0..numbers.length - 1
      val = numbers[j][i].to_i
      (verbose) ? puts("val: #{val}") : nil
      if total == 0
        total = val
      elsif operators[i] == "+"
        total += val
      else
        total *= val
      end
    end
    if verbose
      puts("total: #{total}")
    end
    answer += total
  end
  return answer
end
