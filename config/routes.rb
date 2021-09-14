Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  get 'book' => 'book#index'
  get 'book/ajax_data' => 'book#ajax_data'
  post 'book/create_book' => 'book#create'
end
