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

  # get "/google-signin", to: redirect("/auth/google_oauth2"), as: 'google_signin'
  get "/auth/google_oauth2/callback", to: "sessions#create"

  resources :books, only: [:index, :show, :new, :create, :update, :destroy]
  get '/books/search/:identifier', to: 'books#search_show', as: 'search_show'

  resources :books, only: [:show] do
    resources :user_books, only: [:update]
  end

  resources :books, only: [:show] do 
    resources :reviews, only: [:new, :create, :edit, :update, :destroy]
  end

  resources :shelves, except: [:index, :show]

end
