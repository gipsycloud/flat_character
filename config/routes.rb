Rails.application.routes.draw do
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
