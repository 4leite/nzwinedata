Rails.application.routes.draw do
  
  namespace :admin do
    resources :users
    resources :daily_sales
    resources :sites 
  end

  devise_for :users, controllers: { registrations: "registrations" } 

  root to: 'home#index'

  get 'home', to: 'home#long', as: 'home_long'

  resources :daily_sales

  scope 'sites/:site_id' do
    resources :daily_sales
  end

end
