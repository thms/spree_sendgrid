# Add the preferences for communicaitions types to the user model
Spree::User.class_eval do 
  
  preference :newsletter_subscription, :boolean, :default => true
  preference :availability_subscription, :boolean, :default => true
  preference :new_product_subscription, :boolean, :default => true
  
  attr_accessible :preferred_newsletter_subscription, :preferred_availability_subscription, :preferred_new_product_subscription
  
  # Check if the user has subscriped to the newsletter before signing up, if so, update his preference
  # retired with different logic, all new users are automatically subscribed to all subscriptions
  # after_create :check_newsletter_subscriptions
  
  after_create :create_subscriptions
  
  def create_subscriptions
    if newsletter_subscripttion = Spree::NewsSubscription.newsletter.find_by_email(self.email)
      self.preferred_newsletter_subscription = true
      newsletter_subscription.update_attribute(:user_id, self.id)
    else
      Spree::NewsSubscription.create(:kind => 'newsletter', :email => self.email, :user_id => self.id)
    end 
    Spree::NewsSubscription.create(:kind => 'new_product', :email => self.email, :user_id => self.id)
    Spree::NewsSubscription.create(:kind => 'availability', :email => self.email, :user_id => self.id)
  end
  
  
  def check_newsletter_subscriptions
    if newsletter_subscription = Spree::NewsSubscription.newsletter.find_by_email(self.email)
      self.preferred_newsletter_subscription = true
      newsletter_subscription.update_attribute(:user_id, self.id)
    end
  end
end
