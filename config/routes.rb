Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :departures, only: [:index]
    resources :routes, only: [:index]
    resources :shapes, only: [:show]
    resources :stops, only: [:index, :show]
    resources :trips, only: [:index]
  end

  root to: "index#show"
  get "*path", to: "index#show"
end
