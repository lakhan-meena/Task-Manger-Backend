Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      resources :sessions, only: [] do
        collection do
          post :sign_in
          delete :sign_out
        end
      end
      resources :tasks
    end
  end
end
