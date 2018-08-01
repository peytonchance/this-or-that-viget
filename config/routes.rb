Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'registration', sessions: 'sessions', passwords: 'passwords'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :polls do
    resources :comments, only: [:create, :update, :destroy]
    resources :follows, only: [:create, :destroy]
    resource :option_a, only: [:create, :update, :destroy]
    resource :option_b, only: [:create, :update, :destroy]
    resource :visitor_option_a, only: [:create, :update, :destroy]
    resource :visitor_option_b, only: [:create, :update, :destroy]
  end
  
  resource :profiles, only: [:show]
  resources :privacy, only: [:index]
  
  namespace :api do
    resource :registrations, only: [:create]
    resource :sessions, only: [:create]
    resources :polls, only: [:create, :index, :show]
    resources :users, only: [:show]
    resource :comments, only: [:create, :show]
    resource :follows, only: [:create, :show, :destroy]
  end
  
  root "polls#index"
end
