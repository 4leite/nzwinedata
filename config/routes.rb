Rails.application.routes.draw do

  root to: 'home#index'
  get 'home', to: 'home#long', as: 'home_long'

  namespace :admin do
    resources :daily_sales
  end

  scope '/admin', as: 'admin' do
    resources :users, only: [:destroy]
  end
  match '/users/confirmation', to: 'users/confirmations#update', via: :post, as: :update_user_confirmation
  
  devise_for :users, controllers: { registrations: "users/registrations", confirmations: "users/confirmations" } 

  resources :daily_sales do
    collection do
      post :search, to: :search
    end
  end

  get "/daily_sale_imports", to: redirect("daily_sale_imports/new", status: 302)
  resources :daily_sale_imports, only: [:new, :create] 

  resources 'sites', only: [:index, :show, :edit] do
    get 'users/new', to: 'users/registrations#new'
    match 'users', to: 'users/registrations#create', via: :post
  end

end
