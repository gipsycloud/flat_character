Rails.application.routes.draw do
  devise_for :users,
  path: '/auth',
  path_names: {
    sign_in: 'sign_in',
  }, controllers: { sessions: 'users/sessions', passwords: 'users/passwords', registrations: 'users/registrations', confirmations: 'users/confirmations' }
  
  resources :admins do
    collection do
      get 'report' => "admins#report"
      get 'members' => "admins#members"
      get 'homelist' => "admins#homelist"
      get 'availableroom' => "admins#availableroom"
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
