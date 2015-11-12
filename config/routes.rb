Rails.application.routes.draw do

  root "application#index"

  resources :users do
    resources :orders
  end
  resources :sessions
  resources :albums
  resources :tracks
  resources :orders
  resources :album_orders
  resources :track_orders

  get '/orders/:id', to: 'orders#new'

  get '/users/:id/confirm/:code', to: 'users#confirm'

  get '/application/about' => 'application#about'


  #track and album upload routes
  get '/tracks/upload/:id', to: 'tracks#upload'
  
  get '/albums/upload/:id', to: 'albums#upload'

  #password reset process
  get '/recover', to: 'users#recover'

  post '/users/reset', to: 'users#reset'

  get '/users/:id/reset/:code', to: 'users#change_password'

  post '/users/change_password', to: 'users#new_password'
  # paypal response
  post "/hook" => "orders#hook"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
