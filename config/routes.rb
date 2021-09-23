Rails.application.routes.draw do
  # Sidekiq
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  
  devise_for :users
  root to: 'home#index'

  #Book route
  scope '/book' do
    get '/' => 'book#index'
    get '/find/:id' => 'book#find'
    get '/ajax_data' => 'book#ajax_data'
    post '/create' => 'book#create'
    put '/update/:id' => 'book#update'
    delete '/delete/:id' => 'book#delete'
  end

  #Send mail
  get '/send_mail' => 'book#send_mail'

  # Test Sidekiq
  get '/test_side_kiq' => 'book#test_side_kiq'

  # Test rasack
  get '/test_ransack' => 'book#test_ransack'

  # Get jsonapi.rb
  get '/jsonapi.rb' => 'book#jsonapi'

  #Chat
  scope '/chat' do
    get '/' => 'chat#index'
    get '/detail/:room/:receiver' => 'chat#index'
    get '/get_user' => 'chat#get_user'
    get '/get_chat' => 'chat#get_chat'
    post '/send_message' => 'chat#send_message'
  end
end
