Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  mount Rswag::Ui::Engine => 'api-docs'
  mount Rswag::Api::Engine => 'api-docs'
  
  namespace :api , format: 'json'do
    namespace :v1 do
      resources :todos, only: [:index]
    end
    resources :words, param: :word, only: [:show, :create]
    resources :userwords, only: [:show, :create]
    resources :conversations, only: [:show, :create], param: :userid do
      member do
        get ':session_times', to: 'conversations#session_get', as: :session
      end
    end
    resources :users,param: :username, only: [:create,:show] 
    get 'users/session/:username', to: 'users#show_session'
  end

end
