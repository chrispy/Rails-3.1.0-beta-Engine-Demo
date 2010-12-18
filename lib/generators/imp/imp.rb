require 'rails/generators'
require 'rails/generators/migration'

module Imp
  module Generators

    class Base < Rails::Generators::Base

      def gen(dry_run = false)
        @dry_run = dry_run
        @files = []
      end

      def remove
        gen(true)
        remove_files
      end

      ## Helpers
      def migration_files
        Dir.glob( File.join( migrations_source_root, '*.rb') )
      end

      def ruby_model_files
        migration_names = migration_files.map{|m| Pathname.new(m).basename.to_s.gsub(/\.rb\z/, "")}
        all_model_files = (Imp::ModelMethods.constants - ["Base"]).map{|c| c.downcase}
        (all_model_files - migration_names).map{|f| add_suffix(f) }
      end

      def controller_files
        (Imp::ControllerMethods.constants - ["Base"]).map{|f| add_suffix(f) }
      end

      def metal_files
        (Imp::MetalMethods.constants - ["Base"]).map{|f| add_suffix(f) }
      end


      protected


      def self.source_root
        @source_root = File.expand_path( File.join(__FILE__, "..") )
      end

      def migrations_source_root
        @migrations_source_root ||= File.join( self.class.source_root, 'migrations', 'templates')
      end

      def models_source_root
        @models_source_root ||= File.join( self.class.source_root, 'models', 'templates')
      end

      def controllers_source_root
        @controllers_source_root ||= File.join( self.class.source_root, 'controllers', 'templates')
      end

      def metals_source_root
        @metals_source_root ||= File.join( self.class.source_root, 'metals', 'templates')
      end

      def specs_source_root
        @specs_source_root ||= File.join( self.class.source_root, 'specs', 'templates')
      end

      ## Wrapper which records which file got created
      def add_template(source, target)
        @files << target
        return if @dry_run
        template( source, target )
      end

      ## Wrapper which records which migration got created (using * mask)
      def add_migration(source, target)
        mask = "db/migrate/*#{target}"
        trg = "db/migrate/#{target}"
        @files << mask
        return if @dry_run
        migration_template( source, trg )
      end

      attr_accessor :class_name, :files

      ######################
      ## Migrations
      def migration_name(file)
        Pathname.new(file).basename
      end

      def migration_klass(filename)
        "create_#{filename.to_s.gsub(/\.rb\z/, "").tableize}.rb"
      end

      ######################
      ## Models
      def model_name(file)
        clean_migration(file)
      end

      def model_klass(filename)
        singularize remove_suffix(filename)
      end

      ######################
      ## Controllers
      def controller_name(file)
        "#{clean_migration(file).underscore}.rb"
      end

      def controller_klass(filename)
        remove_suffix(filename)
      end

      ######################
      ## Metals
      def metal_name(file)
        "#{clean_migration(file).underscore}.rb"
      end

      def metal_klass(filename)
        remove_suffix(filename)
      end

      ######################
      ## Specs
      def spec_name(file)
        remove_suffix(clean_migration(file)).downcase
      end

      def spec_klass(filename)
        remove_suffix(filename)
      end


      private


      def clean_migration(file)
        Pathname.new(file).basename.to_s.gsub(/\A\d\d\d_/, "")
      end

      def remove_suffix(filename)
        filename.gsub(/\.rb/, "")
      end

      def add_suffix(filename)
        "#{filename}.rb"
      end

      def pluralize(klass)
        klass.downcase.tableize.capitalize
      end

      def singularize(klass)
        klass.classify.capitalize
      end

      ## Class.removes only files, no directories
      def remove_files
        @files.each do |file|
          Dir.glob( file ).each do |match|
            if File.exists?(match) && File.file?(match)
              puts "=-> Removing file: #{match}"
              FileUtils.remove_entry_secure(match)
            end
          end
        end unless @files.blank?
      end

    end

  end
end

Dir.glob( File.join( Imp.root, 'lib', 'generators', 'imp', "**", "*_generator.rb" ) ).each do |generator|
  require generator.to_s.gsub(/\.rb\z/, "")
end
