Rails.application.routes.draw do
  resources :passwords, controller: 'clearance/passwords', only: %i[create new]
  resource :session, controller: 'sessions', only: [:create]

  resources :users, controller: 'users', only: %i[edit create show update] do
    get '/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    resource :password,
             controller: 'clearance/passwords',
             only: %i[edit update]
  end

  get '/sign-in' => 'sessions#new', as: 'sign_in'
  delete '/sign-out' => 'clearance/sessions#destroy', as: 'sign_out'
  get '/sign-up' => 'clearance/users#new', as: 'sign_up'
  get 'successful-signup' => 'users#successful_signup', as: 'successful_signup'
  root to: 'home#index'

  resources :units, except: %i[index show] do
    get '/sign-up' => 'clearance/users#new', as: 'sign_up'
    resources :users, only: [:destroy]
    resources :activities do
      post 'copy' => 'activities#copy', as: 'copy'
      resources :questions do
        resources :answers, only: %i[new create destroy]
      end
      post '/archive-activity' => 'activities#archive_activity', as: 'archive_activity'
    end
    resources :unit_votes, only: %i[index create destroy]
  end

  resources :activities, only: [:show]

  get 'about' => 'home#about', as: 'about'
  get 'faqs' => 'home#faqs', as: 'faqs'
  get 'resources' => 'home#resources', as: 'activity_resources'
  get '/sitemap' => 'sitemap#sitemap', as: 'sitemap'
  get 'fundraising-activity-ideas' => 'activities#ideas_for_fundraising_activities', as: 'fundraising_activity_ideas'
  get 'troop-activity-ideas' => 'activities#ideas_for_troop_activities', as: 'troop_activity_ideas'
  get 'covid-safe-troop-activity-ideas' => 'activities#ideas_for_covid_safe_troop_activities', as: 'covid_safe_troop_activity_ideas'
end
