Rails.application.routes.draw do
  scope defaults: { format: :json } do
    devise_for :users, only: []
  end

  namespace :v1, defaults: { format: "json" } do
    devise_scope :user do
      post "users/sign_in", to: "sessions#create"
      post "users/sign_up", to: "registrations#create"
      get "users/me", to: "users#me"
      put "users", to: "users#update"
    end
  end
end
