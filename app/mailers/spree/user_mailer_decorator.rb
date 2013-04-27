Spree::UserMailer.class_eval do
  
  # sent to someone for subscribing to a newsletter
  def promo_code_email(email, name, promo_code)
    subject = "A special promo code for ReserveBar.com from your friend #{name}"
    @promo_code = promo_code
    @name = name
    mail(:to => email, :reply_to => "support@reservebar.com", :subject => subject)
  end

end