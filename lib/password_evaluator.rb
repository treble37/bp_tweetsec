require 'ahocorasick'

class PasswordEvaluator
  attr_accessor :dictionary_lookup, :trie

  def initialize(dictionary_lookup)
    @dictionary_lookup = dictionary_lookup
    @trie = AhoC::Trie.new
    @dictionary_lookup.dictionary.each do |word|
      @trie.add(word)
    end
    @trie.build
  end

  def replace_message(message)
    word_list = get_possible_words(message)
    replacements = {}
    word_list.each do |word|
      replacements[word] = get_replacement(word)
      message = message.gsub(/#{word}/, replacements[word])
    end
    message
  end

  def count_char_types(message)
    char_types = { "char" => 0, "number" => 0, "space" => 0, "other" => 0 }
    char_types["char"] = 1 if (message =~ /[a-zA-Z]/)
    char_types["number"] = 1 if (message =~ /[0-9]/)
    char_types["space"] = 1 if (message =~ /\s/)
    char_types["other"] = 1 if (message =~ /[^\s\da-zA-Z]/)
    char_types.values.inject { |s, n| s + n }
  end

  def score(replacement_message)
    replacement_message.length * count_char_types(replacement_message) 
  end

  def strength_category(score)
    category =  "Unacceptable"
    category = "Strong" if score >= 50
    category = "Weak" if score > 10 && score < 50
    category
  end

  private

  def get_replacement(word)
    lookup_word = word.upcase
    possible_replacements = @trie.lookup(lookup_word).sort_by { |token| -token.length }
    replacement = possible_replacements.include?(lookup_word) ?  'z' : word
  end

  def get_possible_words(message)
    message.split(/[\d\s]+/).select { |word| only_letters?(word) }.sort_by { |word| -word.length }
  end

  def only_letters?(word)
    /^[a-zA-Z]+$/ =~ word
  end

end
