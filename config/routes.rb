Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :customer_subscriptions, only: [:create, :destroy]
    end
  end
end
