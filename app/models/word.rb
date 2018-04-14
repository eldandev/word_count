class Word < ApplicationRecord
  def self.store(words_hash)
    words_hash.each do |word, count|
      store_word_count(word, count)
    end
  end

  def self.store_word_count(word, count)
    word_record = Word.find_or_create_by(word: word)
    word_record.count += count
    word_record.save
  rescue ActiveRecord::StaleObjectError, ActiveRecord::RecordNotUnique
    # Stale in case another update was made after read but before write
    # NotUnique since find_or_create_by isn't thread-safe (let alone cluster-safe)
    retry
  end
end
