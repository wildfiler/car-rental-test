Rails.application.routes.draw do
  resources :cars, only: [:index, :create, :destroy]
end
