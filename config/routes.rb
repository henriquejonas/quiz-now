Rails.application.routes.draw do
  
  #== Devise
  devise_for :admin_users, ActiveAdmin::Devise.config

  #== Active Admin
  ActiveAdmin.routes(self)

  resources :sessions, path: 'sessoes', only: [:new, :create, :destroy]
  get 'entrar' => 'sessions#new', as: :login
  get 'sair' => 'sessions#destroy', as: :logout
  match '/auth/:provider/callback', to: 'sessions#create_omniauth', via: [:get]
  match '/auth/failure', to: 'sessions#rejected_omniauth', via: [:get]

  resources :users, path:'usuarios', only: [:new, :create], path_names: {new: 'novo'}

  root 'home#index'
end
