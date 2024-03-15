require 'sidekiq/web'
require 'sidekiq-status/web'

Rails.application.routes.draw do
  # namespace :admins do
  #   get 'dashboard/index'
  # end
  # resources :members
  authenticate :admin do
    mount Sidekiq::Web => '/sidekiq'
  end

  mount ActionCable.server => '/cable'

  devise_for :admins,
    path: '/auth_admin', controllers: {
      sessions: 'admins/sessions',
      registrations: 'admins/registrations'
    }

  devise_for :users,
    path: '/auth',
    path_names: {
      sign_in: 'sign_in', edit: 'edit/profile'
    }, controllers: { 
      sessions: 'users/sessions', 
      passwords: 'users/passwords', 
      registrations: 'users/registrations', 
      confirmations: 'users/confirmations'
    }
  
  devise_scope :user do
    authenticated :user do
      namespace :users do
        get 'dashboard/index', as: :authenticated_root
      end
    end
  end

  devise_scope :admin do
    authenticated :admin do
      scope :main do
        namespace :admins do
          get 'dashboard/index', as: :authenticated_root
          get 'homelist' => "dashboard#homelist"
        end
      end
    end
  end

  resources :admins do
    collection do
      resources :rooms do
        resources :room_images, only: [:create, :destroy]
      end
      resources :users do
        collection do
          get :profile
          post "update_member" => "profile#update_member"
        end
      end
      get 'report' => "admins#report"
      get 'members' => "admins#members"
      get 'availableroom' => "admins#availableroom"
      # namespace 'profile_setting' do
      # end
    end
  end

  scope :main do
    resources :members
    resources :plans
  end

  resources :profile do
    collection do
      get 'detail' => "profile#profile"
    end
  end

  resources :subscriptions, only: [:index, :new, :create]
  resources :homes
  resources :makes, path: :find_a_flatmate, as: :find_a_flatmate
  get "room/(:slug)", to: "homes#room_detail", as: "room_"
  get "list_a_room" => "homes#list_a_room"
  get "find_a_home" => "homes#find_a_home"
  get "find_a_flatmate" => "homes#find_a_flatmate"
  get "aboutus" => "homes#aboutus"
  get "services" => "homes#services"
  get "contact" => "homes#contact"

  get "/verify" => "verify#edit", :as => "verify"
  get "/verify" => "verify#new", :as => "new_verify"
  put "/verify" => "verify#update", :as => "update_verify"
  post "/verify" => "verify#create", :as => "resend_verify"
  
  resources :posts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "homes#index"
end
