Rails.application.routes.draw do
  resources :climbs
  resources :users
  
  #the lat and long at the end are what gives the route the ability to use decimals in the URL and pass them down as params
  get "/climbs/:lat/:long", to: "climbs#hello", lat: /[^\/]+/, long: /[^\/]+/
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
