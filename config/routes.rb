Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get '/users/registration' => 'users#registration'
  resources :users do
    resources :user_badges, only: [:create]
  end

  get '/' => 'users#index'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  namespace :admin do
    resources :management, only: [:index]
  end

  get '/users/:id/add_point' => 'admin/management#add_point'
  post '/remove_points' => 'admin/management#remove_points'

  resources :badges, only: [:new, :create, :index]
  get '/badge-store' => 'badges#index'
  post '/buy-badge' => 'user_badges#buy'
end
