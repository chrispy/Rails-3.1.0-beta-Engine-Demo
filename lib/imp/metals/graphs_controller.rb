module Imp

  module MetalMethods

    module GraphsController
      extend ActiveSupport::Concern
      extend ActiveSupport::Autoload
      include ActionController::Rendering
      include ActionController::Renderers::All

      module InstanceMethods

        def index
          append_view_path "#{Imp::Engine.root}/app/views"
          render
        end

        def graph1
          self.response_body = "Graph 1 from Metal ('white background')"
        end

      end

    end

  end

end
