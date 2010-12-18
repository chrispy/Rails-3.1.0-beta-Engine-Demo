module Imp

  module ControllerMethods

    ## Default enhancements for ApplicationController
    module Base
      extend ActiveSupport::Concern

      module ClassMethods
        def acts_as_imp_controller
          include "Imp::ControllerMethods::#{self.name}".classify.constantize
        end
      end

    end

  end

end

