Spree::UsersController.class_eval do

  # Update user's news subscription preferences, and sendgrid and news_subscription models
  # The news subscription model already has the callbacks to sendgrid and the preferences
  # So we should just call that here, and let it take care of the rest
  
  def update_news_subscriptions
    @user = current_user
    begin
      if params[:user][:preferred_newsletter_subscription] == 'true'
        Spree::NewsSubscription.create(:kind => 'newsletter', :email => @user.email, :user_id => @user.id)
      else
        Spree::NewsSubscription.newsletter.find_by_user_id(@user.id).destroy
      end
    rescue
    end

    begin
      if params[:user][:preferred_availability_subscription] == 'true'
        Spree::NewsSubscription.create(:kind => 'availability', :email => @user.email, :user_id => @user.id)
      else
        Spree::NewsSubscription.availability.find_by_user_id(@user.id).destroy
      end
    rescue
    end
    
    begin
      if params[:user][:preferred_new_product_subscription] == 'true'
        Spree::NewsSubscription.create(:kind => 'new_product', :email => @user.email, :user_id => @user.id)
      else
        Spree::NewsSubscription.new_product.find_by_user_id(@user.id).destroy
      end
    rescue
    end
    
    flash[:notice] = "Your news subscriptions have been updated"
    redirect_to @user
  end

end