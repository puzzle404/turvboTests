Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "restaurants#index"
    resources :restaurants, except: [:index] 
    
    get 'restaurantss/:id/form_turbo_stream', to: 'restaurants#form_turbo_stream', as: :form_turbo_stream
    
    resources :convertations do
      resources :messages
      
    end

  # Defines the root path route ("/")
  # root "articles#index"
end
