Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      devise_for :users, defaults: { format: :json }, controllers: {sessions: 'api/v1/users/sessions', registrations: 'api/v1/users/registrations'}
      devise_for :admins, defaults: { format: :json }, controllers: { sessions: 'api/v1/admins/sessions' }

      post '/sign_in'	=>  'home#sign_in_user', as: :sign_in_user
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
