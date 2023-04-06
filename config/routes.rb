Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  root to: 'questions#index'

  resources :questions do
    member do
      put 'hide'
    end
  end

  resources :users, except: %i[index], param: :nickname do
    member do
      put 'reset_color'
    end
  end

  resource :session, only: %i[new create destroy]
end
