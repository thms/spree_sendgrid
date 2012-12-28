class Spree::NewsSubscriptionsController < Spree::BaseController


  respond_to :js, :only => [:create]

  # create a new subscription from the home page (or any other page)
  # user is not logged i, wants to subscribe to newsletter, provides email address
  # POST /news_subscriptions email address
  def create
    @news_subscription = Spree::NewsSubscription.create(params[:news_subscription])
    respond_with @news_subscription
  end
  
end