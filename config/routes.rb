Rails.application.routes.draw do
  devise_for :users

  resources :properties

  root "home#index"
end
