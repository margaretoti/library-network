Rails.application.routes.draw do
  root to: "books#index"
  
  # resources :books, only: [:index, :new, :edit, :create, :update, :destroy]
  resources :books, only: [:index]
  constraints(Clearance::Constraints::SignedIn.new { |user| user.admin? }) do
    resources :books, only: [:new, :edit, :create, :update, :destroy]
  end
end
