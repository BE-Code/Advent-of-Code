#!/usr/bin/env ruby

# FILE_NAME = "input.txt"
FILE_NAME = "ex_input.txt"

if __FILE__ == $0
  runPath = File.dirname(__FILE__)
  input = File.read(File.join(runPath, FILE_NAME))
  puts input
end
