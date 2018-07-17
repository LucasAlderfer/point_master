Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/users/registration' => 'users#registration'
  resources :users do
    resources :user_badges, only: [:create]
  end

  get '/' => 'users#index'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  get '/users/:id/add_point' => 'admins#add_point'

  resources :admins

  resources :badges, only: [:new, :create]

end
