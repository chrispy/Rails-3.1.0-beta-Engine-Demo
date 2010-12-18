require 'imp'
module Imp

  module Generators

    class ControllersGenerator < Base

      self.desc "Adds all Imp::Engine Controllers"
      self.namespace("imp:controllers")

      ## create as many controllers, as imp/controllers/*.rb exist (reject base.rb)
      def gen(dry_run = false)
        super
        create_controllers
        create_controller_specs
      end

      private

      def create_controllers
        controller_files.each do |file|
          self.class_name = controller_klass(file)
          name = controller_name(self.class_name)
          add_template( File.join(self.controllers_source_root, "base_controller.rb"), "app/controllers/#{name}")
        end
      end


      def create_controller_specs
        controller_files.each do |file|
          self.class_name = controller_klass(file)
          name = controller_name(self.class_name)
          model = name.gsub(/\.rb\z/, "")
          add_template( File.join(self.controllers_source_root, 'controller_spec.rb'),  "spec/controllers/#{model}_spec.rb")
        end
      end

    end

  end
  
end

