Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  root to: 'questions#index'

  resources :questions do
    member do
      put 'hide'
      patch 'edit', to: 'questions#update'
    end
  end

  resources :users, only: %i[new create edit update destroy]
  resources :users do
    member do
      patch 'edit', to: 'users#update'
    end
  end

  resource :session, only: %i[new create destroy]
end
