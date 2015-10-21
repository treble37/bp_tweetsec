RSpec.describe PasswordEvaluator do

  before do
    @dictionary_lookup = DictionaryLookup.new
    @dictionary_lookup.lookup
    @password_evaluator = PasswordEvaluator.new(@dictionary_lookup)
  end

  it "should replace any complete English words in the tweet text with a lowercase letter" do
    tweet_text = "message 1234!"
    expect(@password_evaluator.replace_message(tweet_text)).to eq('z 1234!')
  end

  it "should be limited when the actual words are not in the dictionary" do
    tweet_text = "This message will be replaced 1234!"
    expect(@password_evaluator.replace_message(tweet_text)).to eq('This z z z replaced 1234!')
  end

  it "should prefer longer words when replacing English words in tweet text with a lowercase letter" do
    tweet_text = "password not sword 1234!"
    expect(@password_evaluator.replace_message(tweet_text)).to eq('z z z 1234!')
  end

  it "should count character types according to the rules" do
    replacement_text = "z 1234!"
    expect(@password_evaluator.count_char_types(replacement_text)).to eq(4)
  end

  it "should give an unacceptable rating according to the rules" do
    replacement_text = "z !"
    score = @password_evaluator.score(replacement_text)
    expect(@password_evaluator.strength_category(score)).to eq("Unacceptable")
  end

  it "should give a weak rating according to the rules" do
    replacement_text = "z 1234!"
    score = @password_evaluator.score(replacement_text)
    expect(@password_evaluator.strength_category(score)).to eq("Weak")
  end

  it "should give a strong rating according to the rules" do
    replacement_text = "z z z z z z z 1234!"
    score = @password_evaluator.score(replacement_text)
    expect(@password_evaluator.strength_category(score)).to eq("Strong")
  end

  it "should treat combined words as English words that will be replaced with a lowercase letter" do
    tweet_text = "passwordnot sword 1234!"
#    expect(@password_evaluator.replace_message(tweet_text)).to eq('z z 1234!')
    pending 'tbd'
    fail
  end 

end
