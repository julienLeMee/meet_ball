Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :playgrounds, only: %i[show index]
  get '/map', to: 'playgrounds#map'
end
