Rails.application.routes.draw do
  get '/', to: 'users#home', as: 'root'

  get '/users/new', to: 'users#new', as: 'signup'
  resources :users, only: [:create, :show]

  get '/signin', to: 'sessions#new'
  post '/sessions', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'

  resources :books, only: [:index, :show]

end
