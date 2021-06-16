Rails.application.routes.draw do
  namespace :api  do
    namespace :v1 do 
      devise_for :users, defaults: { format: :json }, controllers: {sessions: 'api/v1/users/sessions', registrations: 'api/v1/users/registrations', passwords: 'api/v1/users/passwords' }
      devise_for :admins, defaults: { format: :json }, controllers: { sessions: 'api/v1/admins/sessions' }

      resources :companies, format: 'json'
      post '/sign_in'	=>  'home#sign_in_user', as: :sign_in_user
      get '/list_of_domains' => 'home#list_of_domains', as: :list_of_domains
      
      # Daxtra Apis 
      get 'resume_parser' => 'home#resume_parser', as: :resume_parser
      get 'add_candidate' => 'home#add_candidate', as: :add_candidate
      get 'get_candidate' => 'home#get_candidate', as: :get_candidate

      get 'add_vacancy' => 'home#add_vacancy', as: :add_vacancy 
      get 'get_vacancy' => 'home#get_vacancy', as: :get_vacancy

    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
