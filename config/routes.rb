Rails.application.routes.draw do
  root to: 'home#index'

  resources :troops do
    resources :activities
    resources :votes, only: [:index, :create, :destroy]
  end
end
