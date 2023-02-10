Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  root to: 'questions#index'

  put '/questions/:id/hide', to: 'questions#hide'
  resources :questions
end
