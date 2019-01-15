Rails.application.routes.draw do
  get '/', to: 'users#home', as: 'root'

  get '/users/new', to: 'users#new', as: 'signup'
  resources :users, only: [:create]
  resources :users, only: [:show] do
    resources :shelves, only: [:show]
  end

  get '/signin', to: 'sessions#new'
  post '/sessions', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'

  resources :books, only: [:index, :show, :new, :create, :update, :destroy]
  get '/books/search/:identifier', to: 'books#search_show', as: 'search_show'

  resources :shelves, except: [:index, :show]

end
