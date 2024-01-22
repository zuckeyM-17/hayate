Rails.application.routes.draw do

  get "up" => "rails/health#show", as: :rails_health_check

  root 'top#index'

  resources :word_searches, only: %i[create new]
  resources :words, only: %i[index show destroy]
  resources :books, only: %i[index create show new] do
    member do
      post :start
      post :next
      post :finish
    end
  end
  resources :readings, only: %i[index show]
  resources :reading_notes, only: %i[create]
end
