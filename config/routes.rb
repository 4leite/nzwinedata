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

  get "/daily_sale_imports", to: redirect("daily_sale_imports/new", status: 302)
  resources :daily_sale_imports, only: [:new, :create] 


  scope 'sites/:site_id' do
    resources :daily_sales
  end

end
