def nDigits(n)
  return n.to_s.length
end

def solvePart1(ranges, verbose = true)
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

def solvePart2(ranges, verbose = true)
  answer = 0
  # skipExcept = 1
  ranges.each do |range|
    # skipExcept -= 1
    # if skipExcept != 0
    #   next
    # end
    i = range[0].to_i
    for i in range[0].to_i..range[1].to_i
      numDigits = nDigits(i)
      for divisor in 1..(numDigits / 2)
        if numDigits % divisor != 0
          next
        end
        chunks = i.to_s.scan(/.{#{divisor}}/)
        (verbose) ? puts(chunks.to_json) : nil
        failed = false
        for chunk in chunks
          if chunk != chunks[0]
            failed = true
            break
          end
        end
        if !failed
          answer += i
          (verbose) ? puts("match") : nil
          break
        end
      end
    end
    (verbose) ? puts("final i: #{i}") : nil
  end
  return answer
end
