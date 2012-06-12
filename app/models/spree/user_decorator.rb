# Add the preferences for communicaitions types to the user model
Spree::User.class_eval do 
  
  preference :newsletter_subscription, :boolean, :default => false
  preference :availability_subscription, :boolean, :default => false
  preference :new_product_subscription, :boolean, :default => false
  
  attr_accessible :preferred_newsletter_subscription, :preferred_availability_subscription, :preferred_new_product_subscription
  
  # Check if the user has subscriped to the newsletter before signing up, if so, update his preference
  after_create :check_newsletter_subscriptions
  
  def check_newsletter_subscriptions
    if newsletter_subscription = Spree::NewsSubscription.newsletter.find_by_email(self.email)
      self.preferred_newsletter_subscription = true
      newsletter_subscription.update_attribute(:user_id, self.id)
    end
  end
end
