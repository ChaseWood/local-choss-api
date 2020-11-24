Rails.application.routes.draw do
  resources :climbs
  #the lat and long at the end are what gives the route the ability to use decimals in the URL and pass them down as params
  get "/climbs/:lat/:long", to: "climbs#getClimbs", lat: /[^\/]+/, long: /[^\/]+/

  post "/settodo/:user_id/:route_id", to: "climbs#settodo"
  post "/setticklist/:user_id/:route_id", to: "climbs#setticklist"

  
  
  resources :users, only: [:create, :show, :index]
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/logged_in', to: 'sessions#is_logged_in?'

  
  
end
