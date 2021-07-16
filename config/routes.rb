Rails.application.routes.draw do
  resources :cars, only: [:create]
end
