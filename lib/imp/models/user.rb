module Imp

  module ModelMethods

    module User
      extend ActiveSupport::Concern

      module InstanceMethods

        def to_debug
          "<#{self.class.name} #{self.id}, login: #{login}, email: #{email}, name: #{name}>"
        end

      end

    end

  end
  
end