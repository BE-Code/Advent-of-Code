#!/usr/bin/env ruby

class Clock
  def initialize
    @start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  end

  def get_time
    Process.clock_gettime(Process::CLOCK_MONOTONIC) - @start_time
  end

  def get_time_pretty
    seconds = get_time
    if seconds >= 60
      minutes = (seconds / 60).floor
      remaining_seconds = seconds % 60
      "#{minutes}m #{format('%.3f', remaining_seconds)}s"
    elsif seconds >= 1
      "#{format('%.3f', seconds)}s"
    elsif seconds >= 0.001
      "#{format('%.3f', seconds * 1000)}ms"
    else
      "#{format('%.3f', seconds * 1_000_000)}µs"
    end
  end
end

def run_part(day, part_num, test_mode, verbose, run_path)
  input_file = test_mode ? "Day #{day}/ex_input#{part_num}.txt" : "Day #{day}/input#{part_num}.txt"
  input_path = File.join(run_path, input_file)

  return unless File.exist?(input_path)

  input = File.read(input_path)
  lines = input.split("\n")

  clock = Clock.new
  answer = send("solvePart#{part_num}", lines, verbose)
  puts "Part #{part_num}"
  puts "Answer: #{answer}"
  puts "Time: #{clock.get_time_pretty}\n\n"
end

if __FILE__ == $0
  if ARGV.empty?
    puts "Usage: ruby main.rb <day_number> [-t|--test] [-v|--verbose]"
    puts "  day_number: 1-12"
    puts "  -t, --test: optional, use example input"
    puts "  -v, --verbose: optional, enable verbose output"
    exit 1
  end

  $verbose = ARGV.include?('-v') || ARGV.include?('--verbose')
  test_mode = ARGV.include?('-t') || ARGV.include?('--test')
  args = ARGV.reject { |a| %w[-v --verbose -t --test].include?(a) }

  day = args[0].to_i

  require_relative "Day #{day}/main.rb"

  run_path = File.dirname(__FILE__)

  puts "Day #{day}#{test_mode ? ' (test mode)' : ''}"
  puts "---------------------"

  run_part(day, 1, test_mode, $verbose, run_path)
  run_part(day, 2, test_mode, $verbose, run_path)
end
