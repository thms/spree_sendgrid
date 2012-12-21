Spree::Core::Engine.routes.prepend do
  
  # routes for creating new subscription from home page:
  resources :news_subscriptions, :only => :create
  
  # add route to allow updating of user's preferences in a separate method - easier to update sendgrid then as well
  resources :users do
    member do
      put :update_news_subscriptions
    end
  end
  
  namespace :admin do
    resources :users do
      member do
        put :update_news_subscriptions
      end
    end    
  end
  
end
