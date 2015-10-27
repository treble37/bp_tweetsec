#!/usr/bin/env ruby

require 'pry'
require 'optparse'
require_relative 'lib/dictionary_lookup'
require_relative 'lib/password_evaluator'
require_relative 'lib/tweet_fetcher'

options = {}
OptionParser.new do |opts|
  opts.banner = "\nTweetSec\n"

  opts.on("-h", "--help", "Help:") do |h|
    puts opts
    exit
  end

  opts.on("-v", "--version") do |v|
    puts opts.banner
    puts "Version 0.0.1"
  end

  opts.on("-t", "--tweets") do |t|
    options[:mock_tweets] = true
  end
end.parse!

tweet_fetcher = TweetFetcher.new
tweet_fetcher.fetch_mentions
@tweets = []

dictionary_lookup = DictionaryLookup.new
dictionary_lookup.lookup

password_evaluator = PasswordEvaluator.new(dictionary_lookup)

if options[:mock_tweets]
  File.open('data/sample_tweets.txt', 'r') do |f|
    f.each_line do |line|
      @tweets << line.strip
    end
  end
else
  #@tweets = tweet_fetcher.timeline_mentions.map { |tweet| tweet.full_text }
end

@tweets.each do |tweet|
  score = password_evaluator.score(tweet)
  puts "Full Tweet: #{tweet}"
  puts "Replaced Tweet: #{password_evaluator.replace_message(tweet)}"
  puts "Score: #{score} / Strength: #{password_evaluator.strength_category(score)}"
  puts ""
end


