Rails.application.routes.draw do
  get "/up", to: proc { [200, {}, ["OK"]] }
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

  scope path: :admins, as: :admin do
    resources :rooms do
      resources :room_images, only: %i[create destroy]
    end

    resources :upgrade, as: :upgrades

    resources :users do
      get :transaction
      post :plan_upgrade

      collection do
        get :profile
        post :update_member, to: "profile#update_member"
      end
    end

    get :detail, to: "profile#profile", as: :profile
    get :report, to: "admins#report"
    get :members, to: "admins#members"
    get :availableroom, to: "admins#availableroom"
    get :setting, to: "admins#setting"
  end

  resources :admins

  # Admin authentication and dashboard
  devise_for :admins,
    path: "/auth_admin",
    controllers: {
      sessions: "admins/sessions",
      registrations: "admins/registrations"
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
    get '/logs', to: 'logs#index'
  end

  # Public website
  resources :subscriptions, only: %i[index new create]
  resources :mailer_subscription_unsubcribes, only: %i[show update]
  resources :rooms do
    collection do
      post :generate_details
    end
  end
  resources :homes
  resources :makes, path: :find_a_flatmate, as: :find_a_flatmate
  get "room/(:slug)", to: "homes#room_detail", as: :room_
  get "list_a_room", to: "homes#list_a_room"
  get "find_a_home", to: "homes#find_a_home"
  get "find_a_flatmate", to: "homes#find_a_flatmate"
  get "aboutus", to: "homes#aboutus"
  get "services", to: "homes#services"
  get "contact", to: "homes#contact"

  namespace :web do
    get "room_checkout", to: "properties#room_checkout"
    get "reserve", to: "properties#reserve"
    post "confirm_reserve", to: "properties#confirm_reserve"
  end

  get "/verify", to: "verify#edit", as: :verify
  get "/verify", to: "verify#new", as: :new_verify
  put "/verify", to: "verify#update", as: :update_verify
  post "/verify", to: "verify#create", as: :resend_verify

  resources :posts
  root "homes#index"


  # JSON API
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

      match "trigger_task", to: "tasks#trigger", via: %i[get post]
    end
  end

  # Route for Chrome DevTools app-specific configuration, returning 404 if not found
  get "/.well-known/appspecific/com.chrome.devtools.json", to: proc { [404, {}, ['']] }
  get "/health/redis", to: "health#redis"

  # Job listings
  resources :job_listings, only: %i[index show]
  delete "saved_jobs/:id", to: "saved_jobs#destroy", as: :saved_job
  post "job_listings/:job_listing_id/saved_jobs", to: "saved_jobs#create", as: :job_saved_jobs
end
