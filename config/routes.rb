Rails.application.routes.draw do
  root to: "books#index"

  resources :books, only: [:index, :new, :edit, :create, :update, :destroy]
end
