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
  resources :readings, only: %i[show]
  resources :reading_notes, only: %i[create]
  resources :daily_task_items, only: %i[index create destroy]
  resources :daily_task_sets, only: %i[index create]
  resources :daily_tasks, only: %i[update]
  resources :links, only: %i[index create destroy]
end
