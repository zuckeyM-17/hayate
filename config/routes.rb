# frozen_string_literal: true

Rails.application.routes.draw do

  get "up" => "rails/health#show", as: :rails_health_check

  mount MissionControl::Jobs::Engine, at: "/jobs"
  root 'top#index'

  get "/sw.js", to: "pwa#service_worker", as: "service_worker"
  get "/manifest.json", to: "pwa#manifest", as: "pwa_manifest"

  get 'signin' => 'sessions#new'
  post 'signin' => 'sessions#create'
  delete 'signout' => 'sessions#destroy'

  resources :authorization_tokens, only: %i[index create destroy]
  resources :word_searches, only: %i[create new]
  resources :words, only: %i[index show destroy]
  resources :books, only: %i[index create show new] do
    member do
      post :start
      post :next
      post :finish
    end
  end
  resources :tasks, only: %i[index show edit update new create destroy] do
    resources :notes, only: %i[index create], controller: 'tasks/notes'
  end
  resources :scheduled_tasks, only: %i[create update]
  resources :completed_tasks, only: %i[create]
  resources :events, only: %i[index new create show]
  resources :notes, only: %i[create destroy]
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
  resource :future_log, only: %i[show]
  resources :logs, only: %i[index show] do
    member do
      get :show_day
      get :add_event
      post :create_event
    end
  end

  namespace :api do
    resources :links, only: %i[create]
    resources :notes, only: %i[create]
    resources :word_searches, only: %i[create]
    resources :words, only: %i[show]
  end

  namespace :admin do
    resources :users, only: %i[index update]
  end
end
