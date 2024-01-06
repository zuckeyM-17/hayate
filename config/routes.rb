Rails.application.routes.draw do

  get "up" => "rails/health#show", as: :rails_health_check

  resources :word_searches, only: %i[index create show new]
end
