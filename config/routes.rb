Rails.application.routes.draw do
  root to: "books#index"

  resources :passwords, only: [:create, :new]
  resource :session, only: [:create]

  resources :users, only: [:create] do
    resource :password, only: [:create, :edit, :update]
  end

  get "/sign_in" => "sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"

  resources :books, only: [:index]

  namespace :admin do
    resources :books, only: [:new, :edit, :create, :update, :destroy]
  end
end
