Rails.application.routes.draw do

  get "up" => "rails/health#show", as: :rails_health_check

  mount MissionControl::Jobs::Engine, at: "/jobs"
  root 'top#index'

  get 'signin' => 'sessions#new'
  post 'signin' => 'sessions#create'
  delete 'signout' => 'sessions#destroy'

  resources :word_searches, only: %i[create new]
  resources :words, only: %i[index show destroy]
  resources :books, only: %i[index create show new] do
    member do
      post :start
      post :next
      post :finish
    end
  end
  resources :tasks, only: %i[index show edit update create destroy] do
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
  resources :feeds, only: %i[index show create update destroy]
  resources :entries, only: %i[index] do
    member do
      patch :read
      patch :fav
    end
    collection do
      post :mark_as_read
    end
  end
  resources :links, only: %i[index create destroy edit update show] do
    member do
      patch :read
    end
  end

  resource :review_tool, only: %i[show]
  resources :logs, only: %i[index show]

  namespace :api do
    resources :links, only: %i[create]
  end

  namespace :admin do
    resources :users, only: %i[index update]
  end
end
