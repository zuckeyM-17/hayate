Rails.application.routes.draw do

  get "up" => "rails/health#show", as: :rails_health_check

  resources :word_searches, only: %i[index create show new]
  resources :books, only: %i[index create show new] do
    member do
      post :start
      post :next
      post :finish
    end
  end
  resources :readings, only: %i[index show]
  resources :chapter_notes, only: %i[create]
end
