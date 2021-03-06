Rails.application.routes.draw do
  scope defaults: { format: :json } do
    devise_for :users, only: [:confirmations]
  end

  namespace :v1, defaults: { format: "json" } do
    devise_scope :user do
      post "users/sign_in", to: "sessions#create"
      post "users/sign_up", to: "registrations#create"
      get "users/me", to: "users#me"
      put "users", to: "users#update"

      resource :passwords, only: %i(update)
      resources :identities, only: :destroy
    end
  end

  devise_for :users, only: %i(omniauth_callbacks), controllers: {
    omniauth_callbacks: "v1/omniauth_callbacks"
  }
end
