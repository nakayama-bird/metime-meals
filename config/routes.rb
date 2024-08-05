Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  # Defines the root path route ("/")
  # root "posts#index"
  root 'staticpages#top'
  get 'login', to:'user_sessions#new'
  post 'login', to:'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :users, only: %i[new create]
  resources :posts do
    collection do
      get :search
    end
  end
  resources :password_resets, only: %i[new create edit update]
  resources :maps, only: %i[index]
  get "myposts" => "posts#myposts"
end
