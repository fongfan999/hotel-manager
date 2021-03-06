Rails.application.routes.draw do

  namespace :admin do
    root 'application#index'

    get 'statistics', to: "statistics#index"

    resources :statistics, only: [] do
      collection do
        get :search
      end
    end
    
    resources :employees, except: [:destroy] do
      member do
        patch :reset_password
        patch :archive
      end
    end

    resources :rooms, except: [:index, :show, :destroy] do
      member do
        patch :archive
      end
    end

    resources :customers, only: [] do
      member do
        patch :archive
      end
    end

    resources :services, except: [:index, :show, :destroy] do
      member do
        patch :archive
      end
    end

    resources :room_types, only: [:index, :edit, :update]
  end

  devise_for :users
  
  root 'welcome#index'

  resources :rooms, only: [:index, :show] do
    collection do
      get :search
    end
  end

  resources :customers, except: [:destroy] do
    collection do
      get :search
    end

    member do
      patch :reset_password
    end
  end

  resources :receipts, except: [:destroy] do
    member do
      patch :pay, to: "receipts#pay"
      post :update_individual
    end

    collection do
      get :search
    end
  end

  resources :services, only: [:index] do
    collection do
      get :search
    end
  end

  resources :bills, only: [:index, :show] do
    resources :services, only: [] do
      member do
        patch :update_service, to: "bills#update_service"
      end
    end

    member do
      get :report, to: "bills#report"
    end

    collection do
      get :search
    end
  end

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
