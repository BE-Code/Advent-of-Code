def solvePart1(lines, verbose = true)
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

def getOperatorSpacing(operatorString)
  operatorSpacing = []
  maxLength = nil
  for i in 0..operatorString.length - 1
    if operatorString[i] != " "
      (maxLength) ? operatorSpacing.push(maxLength - 1) : nil
      maxLength = 1
    else
      maxLength += 1
    end
  end
  operatorSpacing.push(maxLength)
  return operatorSpacing
end

def solvePart2(lines, verbose = true)
  (verbose) ? puts(lines.to_json()) : nil
  answer = 0
  operatorSpacings = getOperatorSpacing(lines[-1])
  (verbose) ? puts("operatorSpacings: #{operatorSpacings.to_json()}") : nil
  operators = lines[-1].split(" ")
  numberLines = lines[0..-2]

  stringOffset = 0
  for operatorIndex in 0..operators.length - 1
    operator = operators[operatorIndex]
    operatorSpacing = operatorSpacings[operatorIndex]
    if verbose
      puts("operatorIndex: #{operatorIndex}")
      puts("operator: #{operator}")
      puts("operatorSpacing: #{operatorSpacing}")
      puts("stringOffset: #{stringOffset}")
    end
    operatorTotal = nil
    for column in 0..operatorSpacing - 1
      numberStr = ""
      for numberLine in numberLines
        digitStr = numberLine[stringOffset + column]
        if digitStr != " "
          numberStr += digitStr
        end
      end
      (verbose) ? puts("#{column}: #{numberStr}") : nil
      if operatorTotal == nil
        operatorTotal = numberStr.to_i
      elsif operator == "+"
        operatorTotal += numberStr.to_i
      else
        operatorTotal *= numberStr.to_i
      end
    end
    (verbose) ? puts("operatorTotal: #{operatorTotal}") : nil
    answer += operatorTotal
    stringOffset += operatorSpacing + 1
  end
  return answer
end
