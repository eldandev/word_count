RSpec.describe 'WordsApiController' do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  context 'store_words' do
    let(:params) { { content: 'yo yo yo', type: 'text' } }

    it 'starts a counting words job' do
      expect(WordCountingJob).to receive(:perform_async).with(params)

      post '/api/store_words', params
    end

    it 'returns 204' do
      allow(WordCountingJob).to receive(:perform_async)

      post '/api/store_words', { content: 'yo yo yo', type: 'text' }

      expect(last_response.status).to eq(204)
    end
  end

  context 'lookup_word' do
    let(:word)  { 'word' }
    let(:count) { 5      }

    it 'returns word count' do
      allow(Word).to receive(:find_or_initialize_by)
                         .with(word: word)
                         .and_return(
                             OpenStruct.new(word: word, count: count)
                         )

      get "/api/lookup_word?word=#{word}"

      body = JSON.parse(last_response.body)

      expect(last_response.status).to eq(200)
      expect(body['word']).to eq(word)
      expect(body['count']).to eq(count)
    end
  end

end