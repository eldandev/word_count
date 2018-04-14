class WordCountingHandler
  def self.handle(content, type)
    text = text_to_go_over(content, type)
    words_hash = WordsCounter.count_words(text)
    Word.store(words_hash)
  end

  def self.text_to_go_over(content, type)
    return page_contents(content) if type == 'url'
    return file_contents(content) if type == 'file'

    content
  end

  def self.page_contents(url)
    Net::HTTP.get(URI.parse(url))
  rescue
    ''
  end

  def self.file_contents(file_path)
    File.read(file_path)
  rescue
    ''
  end
end