Rails.application.routes.draw do
  namespace :api do
    post 'store_words', controller: 'words_api', action: :store_words
    get 'lookup_word',  controller: 'words_api', action: :lookup_word
  end
end
