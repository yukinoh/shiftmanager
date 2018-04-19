Rails.application.routes.draw do
  
  get 'calendar/index/', to: 'calendar#index'
  get 'calendar/index/:i', to: 'calendar#index'
  
  get 'shifts', to: 'shifts#delete'
  get 'shifts/:id', to: 'shifts#delete'
  post 'shifts', to: 'shifts#create'
  post 'shifts/create_multiple_shifts'
  post 'shifts/set_time'
  
  post 'members', to: 'members#create'
  patch 'members/:id', to: 'members#update'
  get 'members/deactivate'
  get 'members/activate'
  
  post 'events', to: 'events#create'
  patch 'events/:id', to: 'events#update'
  get 'events/deactivate'
  get 'events/activate'
  
  post 'notes', to: 'notes#create'
  get 'notes/delete/:id', to: 'notes#delete'
  
  get 'settings/index'
  patch 'settings/:id', to: 'settings#update'
  
  get '/redirect', to: 'gcal#redirect', as: 'redirect'
  get '/callback', to: 'gcal#callback', as: 'callback'
  get "gcal/new_event"
  post 'gcal/new_event/:id', to: 'gcal#new_event'


end
