require 'imp'
module Imp

  module Generators

    class MetalsGenerator < Base

      self.desc "Adds all Imp::Engine Metals"
      self.namespace("imp:metals")

      ## create as many controllers, as imp/metals/*.rb exist (reject base.rb)
      def gen(dry_run = false)
        super
        create_metal_application_controller
        create_metal_controllers
        create_metal_controller_specs
      end

      private

      def create_metal_application_controller
        add_template( File.join(self.metals_source_root, "metal_application_controller.rb"),  "app/controllers/metal_application_controller.rb")
      end

      def create_metal_controllers
        metal_files.each do |file|
          self.class_name = metal_klass(file)
          name = metal_name(self.class_name)
          add_template( File.join(self.metals_source_root, "metal_controller.rb"),  "app/controllers/#{name}")
        end
      end

      def create_metal_controller_specs
        metal_files.each do |file|
          self.class_name = metal_klass(file)
          name = metal_name(self.class_name)
          model = name.gsub(/\.rb\z/, "")
          add_template( File.join(self.metals_source_root, 'metal_spec.rb'),  "spec/metals/#{model}_spec.rb")
        end
      end

    end

  end
  
end

