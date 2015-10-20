RSpec.describe DictionaryLookup do
  it "should return a dictionary of words 86036 long" do
    @dict_lookup = DictionaryLookup.new
    @dict_lookup.lookup('./data/english_words.txt')
    expect(@dict_lookup.dictionary.length).to eq(86036)
  end
end
