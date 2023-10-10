Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  mount Rswag::Ui::Engine => 'api-docs'
  mount Rswag::Api::Engine => 'api-docs'
  
  namespace :api do
    namespace :v1 do
      resources :todos, only: [:index]
    end
      resources :words, param: :word, only: [:show, :create]
      resources :userwords, only: [:show, :create]
      resources :conversations, only: [:show, :create]
      resources :users, only: [:create]
  end

end
