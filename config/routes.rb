Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'registration'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :polls
  
  resource :profiles, only: [:show]
  
  root "polls#index"
end
