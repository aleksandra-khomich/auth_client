Rails.application.routes.draw do
  root to: "home#index"

  get '/auth/:provider/callback', to: 'sessions#create'
  delete 'destroy_session', to: 'sessions#destroy'
  get 'finish_sign_up', to: 'users#finish_sign_up'
  patch '/users/update', to: 'users#update'
  get '/users/confirmation', to: 'users#confirm'
  get '/users/new', to: 'users#new'
  get '/users/edit/:id', to: 'users#edit', as: 'users_edit'
  post '/users/create', to: 'users#create'
  delete '/users/destroy_access_token', to: 'sessions#destroy_access_token'
end
