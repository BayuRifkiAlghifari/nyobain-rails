Rails.application.routes.draw do
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

end
