Rails.application.routes.draw do
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "sessions", only: [:create]

  resources :users, controller: "users", only: [:edit, :create, :show, :update] do
    resource :password,
      controller: "clearance/passwords",
      only: [:edit, :update]
  end

  get "/sign_in" => "sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  get "successful-signup" => "users#successful_signup", as: 'successful_signup'
  root to: 'home#index'

  resources :troops, except: [:index, :show] do
    resources :activities
    resources :votes, only: [:index, :create, :destroy]
  end

  get 'about' => 'home#about', as: 'about'
end
