class DictionaryLookup
  attr_accessor :dictionary

  def initialize
    @dictionary = nil
  end

  def lookup(file_path='./data/english_words.txt')
    @dictionary =  Marshal.load(File.read(file_path))
  end
end
