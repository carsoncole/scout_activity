Rails.application.routes.draw do
  root to: 'home#index'

  resources :troops, except: [:index, :show] do
    resources :activities
    resources :votes, only: [:index, :create, :destroy]
  end

  get 'info' => 'home#info', as: 'info'
end
