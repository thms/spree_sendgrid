Spree::Core::Engine.routes.prepend do
  
  # routes for news subscription:
  resources :news_subscriptions
  get '/newslettersubscribe', :to => 'news_subscriptions#new', :as => :newslettersubscribe
  
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
