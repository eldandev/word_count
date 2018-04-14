require_relative '../../lib/words_counter'

RSpec.describe WordsCounter do
  describe '#count_words' do
    it 'returns an empty hash given an empty string' do
      words_hash = WordsCounter.count_words('')

      expect(words_hash).to eq({})
    end

    it 'ignores special characters' do
      words_hash = WordsCounter.count_words('word><?!@#$%^&*()-=_+{};\'\\/"')

      expect(words_hash).to eq('word' => 1)
    end

    it 'treats all words as lowercase' do
      words_hash = WordsCounter.count_words('Aaa aAa aaA')

      expect(words_hash).to eq('aaa' => 3)
    end

    it 'counts words' do
      text = 'Hi! My name is (what?), my name is (who?), my name is Slim Shady'
      words_hash = WordsCounter.count_words(text)

      expect(words_hash).to eq(
        'hi'    => 1,
        'my'    => 3,
        'name'  => 3,
        'is'    => 3,
        'what'  => 1,
        'who'   => 1,
        'slim'  => 1,
        'shady' => 1,
      )
    end

    it 'foos' do
      path = File.join(File.dirname(__FILE__), 'bla.txt')
      text = File.read(path)
      puts text
    end
  end
end
