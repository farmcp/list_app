ListApp::Application.routes.draw do
  resources :password_resets

  match "signup/", to: 'users#new'

  match 'team/', to: 'static_pages#team'
  match 'about/', to: 'static_pages#about'
  match 'home/', to: 'static_pages#home'

  match 'contribute/', to: 'static_pages#contribute'
  match 'sync/', to: 'sync#show'
  match 'get_sync/', to: 'sync#get_sync'

  root :to => 'static_pages#home'

  resources :users do
    member do
      get :following, :followers
    end
    collection do
      get :syncable_users
    end
  end

  resources :relationships, only: [:destroy, :create]
  resources :sessions, :only => [:new, :create, :destroy]
  resources :lists, :only => [:create, :destroy, :new, :show] do
    member do
      post :add_to
    end
  end
  resources :list_items, :only => [:create, :destroy]
  resources :restaurants, :only => [:new, :create, :show] do
    member do
      resources :comments, :only => [:create, :destroy]
    end
    collection do
      get :search
    end
  end
  match '/signin', :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy', :via => :delete #this means it will be invoked using the DELETE request

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
