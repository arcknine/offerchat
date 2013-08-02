Dashboard::Application.routes.draw do

  resource :profiles do
    collection do
      post "update_avatar"
    end
  end

  resources :agents
  resource :settings
  resources :triggers
  resources :plans

  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}, :controllers => {
    :registrations => "registrations"
  }

  resources :websites do
    collection do
      get "owned"
      get "managed"
    end
    member do
      put "update_settings"
      get "triggers"
    end
  end

  resources :signup_wizard
  resource :passwords


  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  # post 'signup_wizard/step_one' ,:controller => :signup_wizard, :action => 'create'
  # post 'signup_wizard/step_three' ,:controller => :signup_wizard, :action => 'create'


  root :to => 'home#index'

  mount Offerchat::API => '/api/v1/widget/'
end
