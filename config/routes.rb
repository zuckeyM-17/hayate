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
  resources :tasks, only: %i[index create destroy] do
    member do
      patch :done
    end
  end
  resources :notes, only: %i[create]
  resources :readings, only: %i[show]
  resources :reading_notes, only: %i[create]
  resources :daily_task_items, only: %i[index create destroy]
  resources :daily_task_sets, only: %i[index create]
  resources :daily_tasks, only: %i[update]
  resources :links, only: %i[index create destroy] do
    member do
      patch :read
    end
  end

  resource :review_tool, only: %i[show]

  namespace :api do
    resources :links, only: %i[create]
    resources :daily_task_sets, only: %i[create]
  end
end
