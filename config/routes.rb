PaddleSportsNorthAmerica::Application.routes.draw do

  root :to => "home#index"

  # Active Admin has poor support for polymorphic relationships
  # so we have to declare our routes manually
  namespace :admin do
    resources :members do
      resources :addresses
      resources :phone_numbers
      resources :email_addresses
    end

    resources :centers do
      resources :addresses
      resources :phone_numbers
      resources :email_addresses
    end

  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

end
