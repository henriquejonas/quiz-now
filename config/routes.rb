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

  resources :trains, path: 'treino', only: [] do
    collection do
      get :start, path: 'novo'
    end
    member do
      post :finalize, path: 'terminar'
    end
  end

  resources :games, path: 'partida', only: [] do
    collection do
      get  :matchmaking,     path: 'encontrar-jogador'
      get  :start_match,     path: 'comecar-partida'
      get  :finalize_match,  path: 'terminar-partida'
      post :find_match,      path: 'encontrar-partida'
      post :cancel_match,    path: 'cancelar-partida'
      post :answer_question, path: 'responder-questao'
    end
  end

  resources :profiles, path: 'perfil', path_names: {edit: 'editar'}, only: [:edit, :update] do 
    member do
      get :my_points, path: 'minhas-pontuacoes'
    end
  end

  get 'ranking' => 'application#ranking'

  root 'home#index'
end
