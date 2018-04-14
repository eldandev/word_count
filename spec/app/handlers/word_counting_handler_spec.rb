RSpec.describe WordCountingHandler do
  describe '#handle' do
    it 'counts words and stores them' do
      expect(Word).to receive(:store).with('bla' => 3)

      WordCountingHandler.handle('bla bla bla', 'text')
    end

    it 'fetches url pages and counts their words' do
      url = 'http://url.com'
      allow(WordCountingHandler).to receive(:page_contents)
                                        .with(url)
                                        .and_return 'bla bla bla'

      expect(Word).to receive(:store).with('bla' => 3)

      WordCountingHandler.handle(url, 'url')
    end

    it 'counts words in files' do
      file_path = '/var/www/current/Dockerfile'
      allow(WordCountingHandler).to receive(:file_contents)
                                        .with(file_path)
                                        .and_return 'bla bla bla'

      expect(Word).to receive(:store).with('bla' => 3)

      WordCountingHandler.handle(file_path, 'file')
    end

    it 'does nothing when an IO error occurs' do
      allow(Net::HTTP).to receive(:get).and_raise 'error'
      allow(File).to      receive(:read).and_raise 'error'

      expect(Word).to receive(:store).with({}).twice

      WordCountingHandler.handle('http://url', 'url')
      WordCountingHandler.handle('/file', 'file')
    end
  end
end