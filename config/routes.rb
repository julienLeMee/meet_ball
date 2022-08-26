Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :playgrounds, only: %i[show index] do
    resources :games, only: %i[new create]
  end

  get '/games/new', to: 'games#new_choose_playground', as: :new_choose_playground
  post '/games', to: 'games#create_choose_playground', as: :create_choose_playground
  get '/games/:id/confirmed_results', to: 'games#confirmed_results', as: :confirmed_results

  resources :games, only: %i[edit show update destroy] do
    resources :results, only: %i[new create]
  end

  resources :results, only: %i[show]

  get '/playgrounds_nearby', to: 'playgrounds#playgrounds_nearby'
  get '/my_games', to: 'games#my_games'
  get '/dashboard', to: 'users#show'
  get '/dashboard/edit', to: 'users#edit'
  patch '/dashboard', to: 'users#update'
  delete '/dashboard', to: 'users#destroy'
end
