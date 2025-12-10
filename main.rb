#!/usr/bin/env ruby
require 'json'
require 'fileutils'

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

def day_folder(day)
  "Day #{day.to_s.rjust(2, '0')}"
end

def year_path(run_path, year)
  File.join(run_path, year.to_s)
end

def day_path(run_path, year, day)
  File.join(year_path(run_path, year), day_folder(day))
end

def generate_day(day, year, run_path)
  template_path = File.join(run_path, "Day Template")
  dest_path = day_path(run_path, year, day)

  if File.exist?(dest_path)
    puts "Error: #{year}/#{day_folder(day)} already exists"
    exit 1
  end

  unless File.exist?(template_path)
    puts "Error: Day Template folder not found"
    exit 1
  end

  FileUtils.mkdir_p(year_path(run_path, year))
  FileUtils.cp_r(template_path, dest_path)
  puts "Created #{year}/#{day_folder(day)}"
end

def split_recursive(input, separators)
  return input if separators.empty?

  sep, *rest = separators
  parts = input.split(sep)
  return parts if rest.empty?

  parts.map { |part| split_recursive(part, rest) }
end

def load_input(year, day, part_num, test_mode, run_path, config)
  input_key = test_mode ? "part#{part_num}Test" : "part#{part_num}"
  input_filename = config.dig('input', input_key)
  return nil unless input_filename

  input_path = File.join(day_path(run_path, year, day), input_filename)
  return nil unless File.exist?(input_path)

  separator = config['separator'] || "\n"
  separators = Array(separator)
  input = File.read(input_path)

  split_recursive(input, separators)
end

def run_part(year, day, part_num, test_mode, verbose, run_path, config, output: true, redact: false)
  expected_key = "part#{part_num}Test"
  return nil if config.dig('expectedOutput', expected_key).nil?

  input = load_input(year, day, part_num, test_mode, run_path, config)
  return nil unless input

  clock = Clock.new
  answer = send("solvePart#{part_num}", input, verbose)

  if output
    puts "Part #{part_num}"
    puts "Answer: #{redact ? '***' : answer}"
    puts "Time: #{clock.get_time_pretty}\n\n"
  end

  answer
end

def run_all_tests(year, verbose, run_path)
  total = 0
  passed = 0
  failed = 0

  (1..25).each do |day|
    dp = day_path(run_path, year, day)
    config_path = File.join(dp, "config.json")
    main_path = File.join(dp, "main.rb")

    next unless File.exist?(config_path) && File.exist?(main_path)

    require_relative "#{year}/#{day_folder(day)}/main.rb"
    config = JSON.parse(File.read(config_path))
    expected = config['expectedOutput'] || {}

    %w[part1Test part1 part2Test part2].each do |key|
      next if expected[key].nil?

      part_num = key.include?('1') ? 1 : 2
      test_mode = key.include?('Test')
      expected_value = expected[key]

      answer = run_part(year, day, part_num, test_mode, verbose, run_path, config, output: false)
      total += 1

      if answer.to_s == expected_value.to_s
        passed += 1
        puts "✓ #{day_folder(day)} #{key}: #{answer}"
      else
        failed += 1
        puts "✗ #{day_folder(day)} #{key}: got #{answer}, expected #{expected_value}"
      end
    end
  end

  puts "\n---------------------"
  puts "Results: #{passed}/#{total} passed, #{failed} failed"
  exit(failed > 0 ? 1 : 0)
end

def parse_year(args)
  year_idx = args.index { |a| a == '-y' || a == '--year' }
  if year_idx && args[year_idx + 1]
    year = args[year_idx + 1].to_i
    args.delete_at(year_idx + 1)
    args.delete_at(year_idx)
    year
  else
    Time.now.year
  end
end

if __FILE__ == $0
  if ARGV.empty?
    puts "Usage: ruby main.rb <day_number> [-t|--test] [-v|--verbose] [-r|--redact] [-y|--year <year>]"
    puts "       ruby main.rb --test-all [-v|--verbose] [-y|--year <year>]"
    puts "       ruby main.rb -g|--generate <day_number> [-y|--year <year>]"
    puts "  day_number: 1-25"
    puts "  -t, --test: optional, use example input"
    puts "  -v, --verbose: optional, enable verbose output"
    puts "  -r, --redact: optional, redact answers"
    puts "  -y, --year: optional, specify year (default: current year)"
    puts "  --test-all: run all days and verify against expectedOutput"
    puts "  -g, --generate: create a new day folder from template"
    exit 1
  end

  $verbose = ARGV.include?('-v') || ARGV.include?('--verbose')
  run_path = File.dirname(__FILE__)
  args = ARGV.dup
  year = parse_year(args)

  if args.include?('--test-all')
    run_all_tests(year, $verbose, run_path)
    exit 0
  end

  if args.include?('-g') || args.include?('--generate')
    args = args.reject { |a| %w[-g --generate -v --verbose].include?(a) }
    day = args[0].to_i
    generate_day(day, year, run_path)
    exit 0
  end

  test_mode = args.include?('-t') || args.include?('--test')
  redact = args.include?('-r') || args.include?('--redact')
  args = args.reject { |a| %w[-v --verbose -t --test -r --redact].include?(a) }

  day = args[0].to_i

  require_relative "#{year}/#{day_folder(day)}/main.rb"

  config_path = File.join(day_path(run_path, year, day), "config.json")
  config = File.exist?(config_path) ? JSON.parse(File.read(config_path)) : {}

  puts "#{day_folder(day)}#{test_mode ? ' (test mode)' : ''}"
  puts "-----------------------"

  run_part(year, day, 1, test_mode, $verbose, run_path, config, redact: redact)
  run_part(year, day, 2, test_mode, $verbose, run_path, config, redact: redact)
end
