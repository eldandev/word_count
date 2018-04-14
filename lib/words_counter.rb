class WordsCounter
  def self.count_words(text)
    remove_special_characters(text)
    text.downcase!
    words = text.split(' ')

    words.reduce({}) do |words_count, word|
      increment_count(word, words_count)

      words_count
    end
  end

  def self.remove_special_characters(text)
    text.tr!('?><!@#$%^&*()-=_+{};\'/"\\', '')
  end

  def self.increment_count(word, words_count)
    words_count[word] = words_count.has_key?(word) ? words_count[word] + 1 : 1
  end
end