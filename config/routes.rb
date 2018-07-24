Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'registration', sessions: 'sessions', passwords: 'passwords'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :polls do
    resource :comments, only: [:create]
    resources :follows, only: [:create, :destroy]
  end
  
  resource :profiles, only: [:show]
  
  namespace :api do
    resource :registrations, only: [:create, :show]
  end
  
  root "polls#index"
end
