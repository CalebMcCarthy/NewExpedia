
Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

   root 'login#index'
   get 'event/:id' => 'events#show'
   get 'event/:id/edit' => 'events#edit'

   post  'event' => 'events#create'
   get '/newevent' => 'events#new'

   get '/main' => 'events#index'

   get '/users/:id' => 'users#show'
   get 'users/:id/edit' => 'users#editprofile'

   get 'register' => 'users#new'
   post 'users' => 'users#create'

   get 'login' => 'login#login'
   post 'login' => 'login#received'

   get 'logout' => 'login#logout'

   get 'gethotels' => 'events#getHotels'

   get 'posts/create/:id' => 'posts#create'

   post 'posts/post' => 'posts#show'
   
end
