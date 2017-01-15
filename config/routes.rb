Rails.application.routes.draw do
  root 'sessions#new'

  get    'sign_up',  to: 'users#new'
  get    'sign_in',  to: 'sessions#new'
  post   'sign_in',  to: 'sessions#create'
  delete 'sign_out', to: 'sessions#destroy'

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: redirect('sign_in')

  resources :users, except: [:index, :new, :destroy]
end
