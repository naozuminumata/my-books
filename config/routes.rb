Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # root to: 'posts#index'
  # resources :posts
  post "likes/:post_id/create" => "likes#create"
  post "likes/:post_id/destroy" => "likes#destroy"

  root 'posts#index'

  resources :posts, only: %i[new create destroy edit update index] do
    resources :comments, only: %i[create index new]
  end
  resources :comments, only: %i[edit update destroy]

  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"
  get "/auth/:provider/callback" => "users#twitter_create"
  post '/users/guest_sign_in', to: 'users#new_guest'

  get "users/index" => "users#index"
  get "signup" => "users#new"
  post "users/create" => "users#create"
  get "users/:id/show" => "users#show"
  get "users/:id/edit" => "users#edit"
  post "users/:id/update" => "users#update"

  get "posts/index" => "posts#index"
  get "posts/new" => "posts#new"
  post "posts/create" => "posts#create"
  get "posts/:id" => "posts#show"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  post "posts/:id/destroy" => "posts#destroy"

  get "/" => "posts#index"

end
