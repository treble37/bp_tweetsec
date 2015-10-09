RSpec.describe TweetFetcher do
  it "should be able to fetch timeline mentions", :vcr_off do
    twitter_response = "[#<Twitter::Tweet id=651827352247275520>, #<Twitter::Tweet id=651591614050234372>, #<Twitter::Tweet id=647476232259563520>, #<Twitter::Tweet id=645997720751116288>, #<Twitter::Tweet id=644455487036092416>, #<Twitter::Tweet id=644121820057182208>, #<Twitter::Tweet id=643399395937882112>, #<Twitter::Tweet id=643392753339121664>, #<Twitter::Tweet id=638608592313167872>, #<Twitter::Tweet id=630081733329727492>, #<Twitter::Tweet id=625373416456101888>, #<Twitter::Tweet id=621726218690232320>, #<Twitter::Tweet id=617038133495001089>, #<Twitter::Tweet id=604522019292512256>, #<Twitter::Tweet id=582971579430252544>]"
    stub_request(:get, "https://api.twitter.com/1.1/statuses/mentions_timeline.json").to_return(status: 200, body: twitter_response)
    @tweet_fetcher = TweetFetcher.new
    @tweet_fetcher.stub(:fetch_mentions).and_return(twitter_response)
    expect(@tweet_fetcher.fetch_mentions).to eq(twitter_response)
  end
end
