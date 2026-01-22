Rails.application.routes.draw do
  devise_for :users

  # Root and mode switching
  root "home#index"
  post "switch_mode", to: "home#switch_mode"

  # Profile management
  namespace :profiles do
    resource :project_owner_profile, only: [:edit, :update]
    resource :skill_holder_profile, only: [:edit, :update]
  end

  # SNS Links management
  resources :sns_links, only: [:index, :create, :destroy]

  # Projects with nested scouts and applications
  resources :projects do
    member do
      post 'publish'
    end
    resources :scouts, only: [:create]
    resources :applications, only: [:create]
  end

  # Scouts management
  resources :scouts, only: [:index, :show, :new] do
    member do
      post 'accept'
      post 'reject'
    end
  end

  # Applications management
  resources :applications, only: [:index, :show] do
    member do
      post 'accept'
      post 'reject'
    end
  end

  # Matches
  resources :matches, only: [:index, :show]

  # Search
  get "search", to: "search#index"

  # Skills with autocomplete
  resources :skills, only: [:index, :create] do
    collection do
      get 'autocomplete'
    end
  end

  # User skills management
  resources :user_skills, only: [:create, :destroy]

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
