Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/users/registration' => 'users#registration'
  resources :users

  get '/' => 'users#index'
  get '/login' => 'sessions#login'
  post '/login' => 'sessions#authenticate'
  delete '/logout' => 'sessions#destroy'
  get '/users/:id/add_point' => 'admins#add_point'

  resources :admins
end