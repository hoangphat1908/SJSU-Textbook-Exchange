Rails.application.routes.draw do
  
  get 'sessions/new'

  resources :books , only: :index do
    get :autocomplete_book_title, :on => :collection
  end
  resources :posts do
    resources :comments
    resources :books, except: :index
  end

  resources :users do
    member do
      get :confirm_email
    end
  end 

  resources :conversations do
    resources :messages
  end

  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/about'
  get 'help', to: 'static_pages#help'
  get 'about', to: 'static_pages#about'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/users', to: 'users#index'
  get '/post', to: 'posts#index'

  # sortedIndex page
  get 'books/sortedIndex'
  get 'sorted', to: 'books#sortedIndex'

  # mailbox folder routes
  get "mailbox/inbox" => "mailbox#inbox", as: :mailbox_inbox
  get "mailbox/sent" => "mailbox#sent", as: :mailbox_sent
  get "mailbox/trash" => "mailbox#trash", as: :mailbox_trash


  #routes for conversation
  resources :conversations do
    member do
      post :reply
      post :trash
      post :untrash
      post :clear
    end 
  end

  root 'static_pages#home'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
