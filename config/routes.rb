Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :customer_subscriptions, only: [:create, :destroy]

      resources :customers do 
        resources :subscriptions, only: [:index], controller:  'customer_subscriptions'
      end
    end
  end
end
