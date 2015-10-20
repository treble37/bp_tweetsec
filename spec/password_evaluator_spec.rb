RSpec.describe PasswordEvaluator do

  before do
    @password_evaluator = PasswordEvaluator.new
  end

  it "should replace any complete English words in the tweet text with a lowercase letter" do
    tweet_text = "This message will be replaced 1234!"
    expect(@password_evaluator.replace_message(tweet_text)).to eq('a a a a a 1234!')
  end

  it "should prefer longer words when replacing English words in tweet text with a lowercase letter" do
    tweet_text = "password not sword 1234!"
    expect(@password_evaluator.replace_message(tweet_text)).to eq('a a a 1234!')
  end

  it "should treat combined words that do not form actual English words as characters that will not be replaced" do
    tweet_text = "passwordnot sword 1234!"
    expect(@password_evaluator.replace_message(tweet_text)).to eq('a a 1234!')
  end 

end
