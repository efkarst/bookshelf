Rails.application.routes.draw do
  get '/', to: 'users#home', as: 'root'

  get '/users/new', to: 'users#new', as: 'signup'
  resources :users, only: [:create, :show]

  get '/signin', to: 'sessions#new'
  post '/sessions', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'

  get '/books/search', to: 'books#search', as: 'book_search'

  resources :books, only: [:index, :show]



# direct :search do
#   "http://www.rubyonrails.org"
# end

# get '/books/v1/:search', to 'books#create_from_search', as: 'search'


  # get 'https://www.googleapis.com/books/v1/:search', to 'books#create_from_search', as: 'search'

  # get '/auth/facebook/callback' => 'sessions#create'


  # get 'https://www.googleapis.com/books/v1/volumes?q={search terms}'

end
