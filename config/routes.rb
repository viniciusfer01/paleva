Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "stores#index"

  resources :stores, only: [:edit, :update, :show, :index, :new, :create]
  resources :traits, only: [:index, :new, :create]
  resources :menus, only: [:new, :create, :show, :index] do 
    resources :menu_items, only: [:new, :create]
  end
  resources :dishes do 
    post :inactive, on: :member
    post :active, on: :member
    resources :portions, only: [:new, :create, :edit, :update]
  end 
  resources :beverages do 
    post :inactive, on: :member
    post :active, on: :member
    resources :portions, only: [:new, :create, :edit, :update]
  end
  get 'search', to: 'searches#index'
end
