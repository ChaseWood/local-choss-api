Rails.application.routes.draw do
  resources :climbs
  resources :users
  
  get "/climbs/:lat/:long", to: "climbs#hello", lat: /[^\/]+/
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
