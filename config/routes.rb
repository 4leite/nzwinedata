Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :daily_sales
    resources :sites
  end

  devise_for :users, controllers: { registrations: "registrations" } 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'home#index'

  get 'home', to: 'home#long', as: 'home_long'

  resources :sites, :daily_sales

end
