require 'twitter'
require 'dotenv'

class TweetFetcher

  attr_accessor :timeline_mentions

  def initialize
    Dotenv.load
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['consumer_key']
      config.consumer_secret = ENV['consumer_secret']
      config.access_token = ENV['access_token']
      config.access_token_secret = ENV['access_token_secret']
    end
  end

  def fetch_mentions
    @timeline_mentions = @client.mentions_timeline
  end

end
