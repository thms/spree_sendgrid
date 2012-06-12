class Spree::SendgridConfiguration < Spree::Preferences::Configuration

  preference :login, :string, :default => ""
  preference :password, :string, :default => ""  
  
end
