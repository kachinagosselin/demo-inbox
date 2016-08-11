Rails.application.routes.draw do
  root to: 'messages#index'
  devise_for :users
  resources :users
  resources :messages
end
