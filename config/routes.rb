require 'sidekiq/web'
require 'sidekiq-status/web'

Rails.application.routes.draw do
  resources :articles
  # namespace :admins do
  #   get 'dashboard/index'
  # end
  # resources :members
  # if Rails.env.development? || Rails.env.staging?
  #   get '/logs', to: 'logs#index'
  # end

  mount ActionCable.server => '/cable'

  # user login routes for guest and room owner
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

  resources :admins do
    collection do
      resources :rooms do
        resources :room_images, only: [:create, :destroy]
      end
      resources :upgrade do
        # post "transaction", to: 'upgrade#plan_upgrade'
        # collection do
        #   get "plan"
        # end
      end
      resources :users do
        get :transaction
        post "plan_upgrade" => "users#plan_upgrade"
        collection do
          get :profile
          post "update_member" => "profile#update_member"
        end
      end
      get 'report' => "admins#report"
      get 'members' => "admins#members"
      get 'availableroom' => "admins#availableroom"
      get 'setting' => "admins#setting"
      # namespace 'profile_setting' do
      # end
    end
  end

  resources :profile do
    collection do
      get 'detail' => "profile#profile"
    end
  end

  ############
  ############
  ############
  ############

  # main admin routes for maintainance for all website
  devise_for :admins,
  path: '/auth_admin', controllers: {
    sessions: 'admins/sessions',
    registrations: 'admins/registrations'
  }

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

  scope :main do
    resources :members
    resources :plans
  end

  authenticate :admin do
    mount Sidekiq::Web => '/sidekiq'
    get '/logs', to: 'logs#index'
  end

  ###########
  ##########
  ############
  ###############

  # for website routes
  resources :subscriptions, only: [:index, :new, :create]
  resources :mailer_subscription_unsubcribes, only: %i[show update]
  # match 'mailer(/:action(/:id(.:format)))' => 'mailer#:action'
  resources :homes
  resources :makes, path: :find_a_flatmate, as: :find_a_flatmate
  get "room/(:slug)", to: "homes#room_detail", as: "room_"
  get "list_a_room" => "homes#list_a_room"
  get "find_a_home" => "homes#find_a_home"
  get "find_a_flatmate" => "homes#find_a_flatmate"
  get "aboutus" => "homes#aboutus"
  get "services" => "homes#services"
  get "contact" => "homes#contact"

  namespace :web do
      post "room_checkout" => "properties#room_checkout"
  end

  get "/verify" => "verify#edit", :as => "verify"
  get "/verify" => "verify#new", :as => "new_verify"
  put "/verify" => "verify#update", :as => "update_verify"
  post "/verify" => "verify#create", :as => "resend_verify"  # Defines the root path route ("/")
  
  resources :posts
  root "homes#index"


  # apicontroller
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      devise_for :users, path: '', path_names: {
        sign_in: 'login',
        sign_out: 'logout',
        registration: 'signup'
      },
      controllers: {
        sessions: 'api/v1/sessions',
        registrations: 'api/v1/registrations'
      }

      namespace :rooms do
        resources :rooms
      end
    end
  end

end
