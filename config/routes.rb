Rails.application.routes.draw do
  root 'sessions#new'

  get  'signup', to: 'users#new'
  post 'signup', to: 'users#create', as: 'users'

  get  'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'

  delete 'logout', to: 'sessions#destroy'

  get '/auth/:provider/callback', to: 'sessions#create'

  resources :users, except: [:index, :new, :create, :destroy]
end
