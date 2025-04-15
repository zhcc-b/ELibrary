Rails.application.routes.draw do
  devise_for :users

  # API routes
  namespace :api do
    namespace :v1 do
      devise_scope :user do
        post "signup", to: "registrations#create"
        post "login", to: "sessions#create"
        delete "logout", to: "sessions#destroy"
      end

      # API resources
      resources :books do
        resources :reviews, only: [ :create, :update, :destroy ]
      end
      resources :categories, only: [ :index, :show ]
      resources :bookmarks, only: [ :index, :create, :destroy ]
    end
  end

  # Web routes
  root "welcome#index"

  # User authentication routes
  get "/signup", to: "users#new"
  resources :users, except: [ :index, :destroy ]

  # Session routes for login/logout
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"  # Using GET method for logout

  # Book resources with nested reviews
  resources :books do
    resources :reviews, except: [ :index, :show ]
  end

  # Category resources
  resources :categories
  get "/categories/:id/delete", to: "categories#destroy"  # Additional route for GET deletion

  # Bookmark routes
  resources :bookmarks, only: [ :create, :destroy ]
  get "/my_books", to: "bookmarks#index", as: "my_books"
  get "/bookmarks/:id", to: "bookmarks#destroy"  # Additional route for GET deletion

  # Delete routes (with GET method)
  get "/books/:id/delete", to: "books#destroy"
  get "/books/:book_id/reviews/:id/delete", to: "reviews#destroy"
  get "/categories/:id/delete", to: "categories#destroy"
  get "/bookmarks/:id/delete", to: "bookmarks#destroy"

  # Health check endpoint
  get "up" => "rails/health#show", as: :rails_health_check
end
