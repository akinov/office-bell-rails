Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resource :sign_in, only: [:create], controller: :sessions
  end

  get 'slack/authorize_callback'

  get 'dashboard/index'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'

  root to: 'home#index'
end
