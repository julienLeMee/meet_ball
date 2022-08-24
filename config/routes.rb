Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :playgrounds, only: %i[show index] do
    resources :games, only: %i[new create]
  end

  resources :games, only: %i[edit show update destroy]

  get '/playgrounds_nearby', to: 'playgrounds#playgrounds_nearby'
  get '/my_games', to: 'games#my_games'
  get '/dashboard', to: 'users#show'
  get '/dashboard/edit', to: 'user#edit'
  patch '/dashboard', to: 'user#update'
end
