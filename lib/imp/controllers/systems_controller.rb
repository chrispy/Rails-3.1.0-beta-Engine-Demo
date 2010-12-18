module Imp

  module ControllerMethods

    module SystemsController
      extend ActiveSupport::Concern

      module InstanceMethods

        def index
          @user = User.create(:login => "bla#{rand(1000)}", :email => "foo", :name => :bar)
        end

        def system1
        end

      end

    end

  end
  
end