# Manages subscriptions to newsletters and alerts for users that do not yet have an account (or maybe for all)
require 'gatling_gun'
module Spree
  class NewsSubscription < ActiveRecord::Base
    
    # These correspond to the preferences in the user model, add _subscription to get to the preference
    KINDS = [:newsletter, :availability, :new_product]
    attr_accessible :kind, :email, :user_id
    belongs_to :user
    validates_presence_of :email
    validates_uniqueness_of :email, :scope => :kind
    
    
    scope :newsletter, where(:kind => 'newsletter')
    scope :availability, where(:kind => 'availability')
    scope :new_product, where(:kind => 'new_product')
    
    def to_preference
      "preferred_#{self.kind}_subscription"
    end
    
    after_create :enable_user_preferences_and_sendgrid
    before_destroy :disable_user_preferences_and_sendgrid
    
    def enable_user_preferences_and_sendgrid
       update_user_preferences(true)
       update_sendgrid(true)
    end

    def disable_user_preferences_and_sendgrid
       update_user_preferences(false)
       update_sendgrid(false)
    end
    
    def update_user_preferences(subscribe)
      if user = Spree::User.find_by_email(self.email)
        eval "user.#{self.to_preference} = #{subscribe}"
      end
    end
    
    # Uses kind (as the name of the list) to select a recipient list
    def update_sendgrid(subscribe)
      begin
        sendgrid = GatlingGun.new(Spree::Sendgrid::Config.login, Spree::Sendgrid::Config.password)
        if subscribe
          sendgrid.add_email("#{self.kind}_#{Rails.env}", {:name => self.email, :email => self.email})
        else
          response = sendgrid.delete_email("#{self.kind}_#{Rails.env}", [self.email])
        end
      rescue
        # Fails silently for now
      end
    end
  end
end

# TODO: enable subscribing here, plus all the bounce and other data
# ability to talk to sendgrid - what is their API
# Observe user model, if subscription preferences change there, make changes here
# Observe user maodel, if new user created, check if he is already subscribed to news letter and set preference accordingly.
