require 'imp'
module Imp

  module Generators

    class ModelsGenerator < Base

      self.desc "Adds all Imp::Engine models"
      self.namespace("imp:models")

      def gen(dry_run = false)
        super
        create_models
        create_model_specs
      end

      private

      ## Models
      def create_models
        create_activerecord_models
        create_ruby_models
      end

      def create_activerecord_models
        migration_files.each do |file|
          model = model_name(file)
          self.class_name = model_klass(model)
          add_template( File.join(self.models_source_root, 'activerecord_model.rb'), "app/models/#{model}")
        end
      end

      def create_ruby_models
        ruby_model_files.each do |file|
          self.class_name = model_klass(file)
          add_template( File.join(self.models_source_root, 'ruby_model.rb'), "app/models/#{file}")
        end
      end


      ## Specs
      def create_model_specs
        create_activerecord_specs
        create_ruby_specs
      end

      def create_activerecord_specs
        migration_files.each do |file|
          model = model_name(file)
          self.class_name = model_klass(model)
          add_template( File.join(self.models_source_root, 'activerecord_spec.rb'),  "spec/models/#{model}")
        end
      end

      def create_ruby_specs
        ruby_model_files.each do |file|
          self.class_name = model_klass(file)
          add_template( File.join(self.models_source_root, 'ruby_spec.rb'),  "spec/models/#{file}")
        end
      end

    end

  end

end

