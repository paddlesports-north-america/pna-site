PaddleSportsNorthAmerica::Application.routes.draw do

  root :to => "home#landing"

  get 'home' => "home#index"
  get 'about' => "home#about"
  get 'calendar' => "home#calendar"
  get 'for-paddlers' => "home#paddlers"
  get 'for-coaches' => "home#coaches"
  get 'membership' => "home#membership"
  get 'contact' => "home#contact"

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
