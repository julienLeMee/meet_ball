Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  ################# PLAYGROUND #################

  resources :playgrounds, only: %i[show index] do
    resources :games, only: %i[new create]
  end

  ################# GAMES #################
  get '/games/new', to: 'games#new_choose_playground', as: :new_choose_playground

  resources :games, only: %i[edit show update destroy] do
    resources :results, only: %i[new create]
  end

  ################# PLAYERS #################

  resources :players, only: :create
  patch '/games/:game_id/players', to: 'players#update', as: :update_player

  ################# RESULTS #################

  resources :results, only: %i[show]

  ################# CHATROOM #################

  resources :chatrooms, only: :show do
    resources :messages, only: :create
  end

  ################# CUSTOM ROUTES #################

  post '/games', to: 'games#create_choose_playground', as: :create_choose_playground
  get '/results/:id/confirmed_results', to: 'results#confirmed_results', as: :confirmed_results
  get '/playgrounds_nearby', to: 'playgrounds#playgrounds_nearby'
  get '/my_games', to: 'games#my_games'
  get '/dashboard', to: 'users#show'
  get '/dashboard/edit', to: 'users#edit'
  patch '/dashboard', to: 'users#update'
  delete '/dashboard', to: 'users#destroy'
  post '/user_badges', to: 'user_badges#create', as: :user_badge
end
