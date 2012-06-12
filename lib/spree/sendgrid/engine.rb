module Spree
  module Sendgrid
    class Engine < Rails::Engine
      isolate_namespace Spree
      engine_name 'spree_sendgrid'

      initializer "spree.sendgrid.preferences", :before => :load_config_initializers do |app|
        Spree::Sendgrid::Config = Spree::SendgridConfiguration.new
      end

      def self.activate
        Dir.glob(File.join(File.dirname(__FILE__), "../../../app/overrides/*.rb")) do |c|
          Rails.application.config.cache_classes ? require(c) : load(c)
        end
        
        Dir.glob(File.join(File.dirname(__FILE__), '../../../app/**/*_decorator*.rb')) do |c|
          Rails.configuration.cache_classes ? require(c) : load(c)
        end
        
      end

      config.autoload_paths += %W(#{config.root}/lib)
      config.to_prepare &method(:activate).to_proc

      
 
    end
  end
end
