module Imp

  module ModelMethods

    module System
      extend ActiveSupport::Concern

      module InstanceMethods
        attr_accessor :name

        def initialize(name = nil)
          @name = name
        end

        def alarm
          "#{name} sent an alarm"
        end
        
      end

    end

  end
  
end