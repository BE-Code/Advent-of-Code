def nDigits(n)
  return n.to_s.length
end

def solvePart1(ranges, verbose)
  answer = 0
  # skipExcept = 3
  ranges.each do |range|
    # skipExcept -= 1
    # if skipExcept != 0
    #   next
    # end
    i = range[0].to_i
    while i <= range[1].to_i
      (verbose) ? puts("i: #{i}") : nil
      if nDigits(i).odd?
        i = 10**nDigits(i)
        next
      end
      frontHalf = i.to_s[0..(nDigits(i) / 2 - 1)]
      backHalf = i.to_s[(nDigits(i) / 2)..-1]
      if frontHalf == backHalf
        answer += i
      end
      if backHalf < frontHalf
        i = (frontHalf + frontHalf).to_i
      else
        newFrontHalf = (frontHalf.to_i + 1).to_s
        i = (newFrontHalf + newFrontHalf).to_i
      end
    end
    (verbose) ? puts("final i: #{i}") : nil
  end
  return answer
end

def solvePart2(ranges, verbose)
  answer = 0
  ranges.each do |range|
    # puts range.to_json
    answer += 1
  end
  return answer
end
