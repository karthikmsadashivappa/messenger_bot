Rails.application.routes.draw do
  resources :messages
  get 'callback/index'
  post '/' => 'callback#recieved_data'

  get 'callback/recieved_data'
  root 'callback#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
