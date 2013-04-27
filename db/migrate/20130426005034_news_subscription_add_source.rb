class NewsSubscriptionAddSource < ActiveRecord::Migration
  def up
    add_column :spree_news_subscriptions, :source, :string, :null => false, :default => 'homepage'
    Spree::NewsSubscription.update_all(:source => 'homepage')
  end

  def down
    remove_column :spree_news_subscriptions, :source
  end
end
