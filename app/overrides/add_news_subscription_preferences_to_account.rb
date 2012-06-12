Deface::Override.new(:virtual_path => "spree/users/show",
                     :name => "add_news_subscription_to_account",
                     :insert_after => "[data-hook='account_my_orders']",
                     :partial => "spree/users/news_subscriptions",
                     :disabled => false)
