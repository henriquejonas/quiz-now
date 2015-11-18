Rails.application.routes.draw do
  
  #== Devise
  devise_for :admin_users, ActiveAdmin::Devise.config

  #== Active Admin
  ActiveAdmin.routes(self)

  resources :sessions, path: 'sessoes', only: [:new, :create, :destroy]
  get 'entrar' => 'sessions#new', as: :login
  get 'sair' => 'sessions#destroy', as: :logout

  root 'home#index'
end
