Rails.application.routes.draw do
  # namespace :admins do
  #   get 'dashboard/index'
  # end

  devise_for :admins,
  path: '/auth_admin', controllers: {
    sessions: 'admins/sessions',
    registrations: 'admins/registrations'
  }

  # resources :members
  devise_for :users,
    path: '/auth',
    path_names: {
      sign_in: 'sign_in',
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
      namespace :admins do
        get 'dashboard/index', as: :authenticated_root
        get 'homelist' => "dashboard#homelist"
      end
    end
  end

  resources :admins do
    collection do
      resources :rooms
      resources :members
      get 'report' => "admins#report"
      get 'members' => "admins#members"
      get 'availableroom' => "admins#availableroom"
      # namespace 'profile_setting' do
      # end
    end
  end

  resources :profile do
    collection do
      get 'detail' => "profile#profile"
    end
  end

  resources :homes
  get "list_a_room" => "homes#list_a_room"
  get "find_a_home" => "homes#find_a_home"
  get "find_a_flatmate" => "homes#find_a_flatmate"
  get "aboutus" => "homes#aboutus"
  get "services" => "homes#services"
  get "contact" => "homes#contact"
  
  resources :posts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "homes#index"
end
