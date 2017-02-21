Rails.application.routes.draw do
  get '/' => 'users#index'

  post '/login' => 'users#login'

  get '/register' => 'users#register'

  get '/borrower/:id' => 'users#show_borrower'

  get '/details/:id' => 'users#borrowers_details'

  get '/lender/:id' => 'users#show_lender'

  post '/create_borrower' => 'users#create_borrower'

  post '/create_lender' => 'users#create_lender'

  post '/lend/:id' => 'users#lend'

  post '/logout' => 'users#logout'

  post '/thank/:id' => 'users#thank'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
