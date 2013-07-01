PaddleSportsNorthAmerica::Application.routes.draw do

  root :to => "home#index"

  # Active Admin has poor support for polymorphic relationships
  # so we have to declare our routes manually

  namespace :admin do
    get 'members/autocomplete' => 'members#autocomplete'

    resources :members do
      resources :addresses
      resources :phone_numbers
      resources :email_addresses

      resources :memberships do
        get 'print' => 'memberships#print'
      end

      resources :qualifications do
        get 'print' => 'qualifications#print'
      end

    end

    resources :centers do
      resources :addresses
      resources :phone_numbers
      resources :email_addresses
    end

    get 'products/autocomplete' => 'products#autocomplete'
  end

  devise_for :admin_users, ActiveAdmin::Devise.config

  begin
    ActiveAdmin.routes(self)
  rescue
    Rails.logger.warn "Failed to initialize aa routes"
  end

end
