Airpic::Application.routes.draw do
  devise_for :users

  root 'home#index'
  post '/order'=> 'order#create'

  resources :payments
  resources :recipients
  resources :orders, only: [:create, :index]
end
