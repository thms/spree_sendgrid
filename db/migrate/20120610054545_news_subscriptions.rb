class NewsSubscriptions < ActiveRecord::Migration
  def change
    create_table :spree_news_subscriptions do |t|
      t.references :user # might be nil, if the user subscribed from the home page
      t.string  :email, :null => false, :default => ''
      t.string  :kind, :null => false, :default => ''
      t.datetime :bounced_at
      t.datetime :last_sent
      t.timestamps
    end
  end


end
