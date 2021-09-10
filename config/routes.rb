Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  get 'book' => 'book#index'
  post 'create_book' => 'book#create'
end
