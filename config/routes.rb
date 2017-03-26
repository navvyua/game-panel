Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root 'posts#index'

  get    'sign_up',  to: 'users#new'
  get    'sign_in',  to: 'sessions#new'
  post   'sign_in',  to: 'sessions#create'
  delete 'sign_out', to: 'sessions#destroy'

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: redirect('sign_in')

  resources :bug_tickets
  resources :posts

  resources :users, except: [:index, :show, :new, :destroy] do
    get 'profile', to: 'users#show', on: :member
    resources :characters, except: :delete
    resources :requests, except: [:edit, :update] do
      resources :comments, only: [:create, :destroy]
    end
    resources :reports, except: [:edit, :update] do
      resources :comments, only: [:create, :destroy]
      get :autocomplete_character_last_name, on: :collection
    end
  end

  namespace :admin do
    resources :characters,  only: [:index, :update]
    resources :requests,    only: [:index, :update, :destroy]
    resources :bug_tickets, only: [:index]
    resources :reports,     only: [:index, :destroy]
  end
end
