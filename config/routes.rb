Rails.application.routes.draw do
  ### Home
  get '/', to: 'users#home', as: 'root'

  ### Users - Signup
  get '/users/new', to: 'users#new', as: 'signup'
  resources :users, only: [:create]

  ### Sign In
  get '/signin', to: 'sessions#new'
  post '/sessions', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'
  get "/auth/google_oauth2/callback", to: "sessions#create"

  ### Book - most popular
  get '/books/popular', to: 'books#popular', as: 'most_popular_books'

  ### Books - Index, Show, Update, Destroy
  resources :books, only: [:index, :show, :update, :destroy]

  ### Books - New, Create, Show from Google Search
  get '/books/search/new', to: 'books#new_search', as: 'new_book_search'
  post '/books', to: 'books#create_search', as: 'create_book_search'
  get '/books/search/:identifier', to: 'books#show_search', as: 'book_search'

  ### User Book Activity - Update 
  resources :user_books, only: [:update]

  ### Book Reviews - New, Create, Edit, Update, Destroy
  resources :books, only: [:show] do 
    resources :reviews, only: [:new, :create, :edit, :update, :destroy]
  end

  ### Users Shelves - Show
  resources :users, only: [:show] do
    resources :shelves, only: [:show]
  end

  ### Shelves - New, Create, Edit, Update, Destroy
  resources :shelves, except: [:index, :show]

end
