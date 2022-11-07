Rails.application.routes.draw do

  root to: 'public/homes#top'
  get '/about' => 'public/homes#about', as: 'about'

  get '/customers' => 'public/customers#show'
  get '/customers/information/edit' => 'public/customers#edit'
  patch '/customers/information/' => 'public/customers#update'
  get '/customers/confirm' => 'public/customers#confirm'
  patch '/customers' => 'public/customers#unsubscribe', as: 'customers_unsubscribe'

  delete '/cart_items' => 'public/cart_items#destroy_all'


  scope module: :public do
    resources :addresses, only: [:create, :index, :edit, :update, :destroy]
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:create, :index, :update, :destroy]
  end

  namespace :admin do
    root to: 'homes#top'
    resources :homes, only: [:top]
    resources :genres, only: [:create, :index, :edit, :update]
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

end
