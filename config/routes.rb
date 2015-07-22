Rails.application.routes.draw do
  root to: "home#index"

  get '/auth/:provider/callback', to: 'sessions#create'
  delete 'destroy_session', to: 'sessions#destroy'
  get 'finish_sign_up', to: 'users#finish_sign_up'
  post 'update_user', to: 'users#update'
  get '/users/confirmation', to: 'users#confirm'
  get '/users/new', to: 'users#new'
  post '/users/create', to: 'users#create'
end
