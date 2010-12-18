require 'imp'
require 'rails'

module Imp
  class Engine < Rails::Engine
    engine_name "imp"

    ## they run before user initializers
    generators do
      require "generators/imp/imp"
    end

    ## they run after user initializers
    initializer "action_controller" do
      ActiveSupport.on_load(:action_controller) do
        ::ActionController::Base.send :include, Imp::ControllerMethods::Base
        ::ActionController::Metal.send :include, Imp::MetalMethods::Base
      end
    end

    initializer "active_record" do
      ActiveSupport.on_load(:active_record) do
        ::ActiveRecord::Base.send :include, Imp::ModelMethods::Base
      end
    end

    initializer 'action_view.helper_methods' do |app|
      ActiveSupport.on_load(:action_view) do
        ::ActionView::Base.send :include, Imp::HelperMethods::ApplicationHelper
      end
    end

    initializer "static assets" do |app|
      app.middleware.use ::ActionDispatch::Static, "#{root}/public"
    end

    ## Untested Example howto load engine routes into action_mailer
#    initializer "action_mailer.set_configs" do |app|
#      ActiveSupport.on_load(:action_mailer) do
#        extend ::AbstractController::Railties::RoutesHelpers.with(self.routes)
##        include self.routes.mounted_helpers
##        options.each { |k,v| send("#{k}=", v) }
#      end
#    end

  end
end
