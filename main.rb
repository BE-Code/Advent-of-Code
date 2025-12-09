#!/usr/bin/env ruby
require 'json'

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

def split_recursive(input, separators)
  return input if separators.empty?

  sep, *rest = separators
  parts = input.split(sep)
  return parts if rest.empty?

  parts.map { |part| split_recursive(part, rest) }
end

def load_input(day, part_num, test_mode, run_path, config)
  input_key = test_mode ? "part#{part_num}Test" : "part#{part_num}"
  input_filename = config.dig('input', input_key)
  return nil unless input_filename

  input_path = File.join(run_path, "Day #{day}", input_filename)
  return nil unless File.exist?(input_path)

  separator = config['separator'] || "\n"
  separators = Array(separator)
  input = File.read(input_path)

  split_recursive(input, separators)
end

def run_part(day, part_num, test_mode, verbose, run_path, config, output: true)
  expected_key = "part#{part_num}Test"
  return nil if config.dig('expectedOutput', expected_key).nil?

  input = load_input(day, part_num, test_mode, run_path, config)
  return nil unless input

  clock = Clock.new
  answer = send("solvePart#{part_num}", input, verbose)

  if output
    puts "Part #{part_num}"
    puts "Answer: #{answer}"
    puts "Time: #{clock.get_time_pretty}\n\n"
  end

  answer
end

def run_all_tests(verbose, run_path)
  total = 0
  passed = 0
  failed = 0

  (1..12).each do |day|
    day_path = File.join(run_path, "Day #{day}")
    config_path = File.join(day_path, "config.json")
    main_path = File.join(day_path, "main.rb")

    next unless File.exist?(config_path) && File.exist?(main_path)

    require_relative "Day #{day}/main.rb"
    config = JSON.parse(File.read(config_path))
    expected = config['expectedOutput'] || {}

    %w[part1Test part1 part2Test part2].each do |key|
      next if expected[key].nil?

      part_num = key.include?('1') ? 1 : 2
      test_mode = key.include?('Test')
      expected_value = expected[key]

      answer = run_part(day, part_num, test_mode, verbose, run_path, config, output: false)
      total += 1

      if answer.to_s == expected_value.to_s
        passed += 1
        puts "✓ Day #{day} #{key}: #{answer}"
      else
        failed += 1
        puts "✗ Day #{day} #{key}: got #{answer}, expected #{expected_value}"
      end
    end
  end

  puts "\n---------------------"
  puts "Results: #{passed}/#{total} passed, #{failed} failed"
  exit(failed > 0 ? 1 : 0)
end

if __FILE__ == $0
  if ARGV.empty?
    puts "Usage: ruby main.rb <day_number> [-t|--test] [-v|--verbose]"
    puts "       ruby main.rb --test-all [-v|--verbose]"
    puts "  day_number: 1-12"
    puts "  -t, --test: optional, use example input"
    puts "  -v, --verbose: optional, enable verbose output"
    puts "  --test-all: run all days and verify against expectedOutput"
    exit 1
  end

  $verbose = ARGV.include?('-v') || ARGV.include?('--verbose')
  run_path = File.dirname(__FILE__)

  if ARGV.include?('--test-all')
    run_all_tests($verbose, run_path)
    exit 0
  end

  test_mode = ARGV.include?('-t') || ARGV.include?('--test')
  args = ARGV.reject { |a| %w[-v --verbose -t --test].include?(a) }

  day = args[0].to_i

  require_relative "Day #{day}/main.rb"

  config_path = File.join(run_path, "Day #{day}", "config.json")
  config = File.exist?(config_path) ? JSON.parse(File.read(config_path)) : {}

  puts "Day #{day}#{test_mode ? ' (test mode)' : ''}"
  puts "---------------------"

  run_part(day, 1, test_mode, $verbose, run_path, config)
  run_part(day, 2, test_mode, $verbose, run_path, config)
end
