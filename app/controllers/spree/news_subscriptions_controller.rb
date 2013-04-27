class Spree::NewsSubscriptionsController < Spree::BaseController


  respond_to :js, :only => [:create]

  # create a new subscription from the home page (or any other page)
  # user is not logged in, wants to subscribe to newsletter, provides email address
  # POST /news_subscriptions email address
  def create
    @redirect_to = params[:news_subscription].delete(:redirect_to) rescue nil
    @promo_code = params[:news_subscription].delete(:promo_code) rescue nil
    @name = params[:news_subscription].delete(:name) rescue false
    @news_subscription = Spree::NewsSubscription.create(params[:news_subscription])
    unless @promo_code.blank?
      Spree::UserMailer.promo_code_email(params[:news_subscription][:email], @name, @promo_code).deliver
    end
    respond_with @news_subscription, @redirect_to, @promo_code, @name
  end
  
end