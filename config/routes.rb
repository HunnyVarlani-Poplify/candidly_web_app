Rails.application.routes.draw do
  scope '/api' do
    scope '/v1' do 
      devise_for :users, defaults: { format: :json }, controllers: {sessions: 'api/v1/users/sessions', registrations: 'api/v1/users/registrations'}
      devise_for :admins, defaults: { format: :json }, controllers: { sessions: 'api/v1/admins/sessions' }

      resources :companies
      post '/sign_in'	=>  'home#sign_in_user', as: :sign_in_user
      get '/list_of_domains' => 'home#list_of_domains', as: :list_of_domains
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
