Rails.application.routes.draw do
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "sessions", only: [:create]


  resources :users, controller: "users", only: [:edit, :create, :show, :update] do
    get '/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
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
    resources :activities do
      resources :questions do
        resources :answers, only: [:new, :create, :destroy]
      end
    end
    get '/troop-created' => 'troops#troop_created', as: 'troop_created'
    post '/archive-activity' => 'activities#archive_activity', as: 'archive_activity'
    resources :votes, only: [:index, :create, :destroy]
  end

  get 'about' => 'home#about', as: 'about'
  get 'resources' => 'home#resources', as: 'activity_resources'
  get '/sitemap' => 'sitemap#sitemap', as: 'sitemap'
end
