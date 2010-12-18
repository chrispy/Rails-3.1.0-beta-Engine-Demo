module Imp

  module MetalMethods

    ## Default enhancements for MetalController
    module Base
      extend ActiveSupport::Concern

      module ClassMethods
        def acts_as_imp_metal
          include "Imp::MetalMethods::#{self.name}".classify.constantize
        end
      end

    end

  end

end

