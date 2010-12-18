module Imp

  module ModelMethods

    ## Default enhancements for all Models
    module Base
      extend ActiveSupport::Concern

      module ClassMethods
        def acts_as_imp_model
          include "Imp::ModelMethods::#{self.name}".classify.constantize
        end
      end

    end

  end

end

