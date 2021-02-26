Rails.application.routes.draw do
  # devise_for :users

  scope module: :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [:create, :update, :show] do
        collection do
          post :sign_in, controller: :sessions, action: :create
        end
      end
    end
  end
end
