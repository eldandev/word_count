class Api::WordsApiController < ActionController::API
  def store_words
    WordCountingJob.perform_async(content: params[:content],
                                  type:    params[:type])
  end

  def lookup_word
    word = Word.find_or_initialize_by(word: params[:word])

    render json: { word: word.word, count: word.count}
  end
end