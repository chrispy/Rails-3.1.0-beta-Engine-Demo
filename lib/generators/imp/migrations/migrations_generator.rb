require "imp"
module Imp

  module Generators

    class MigrationsGenerator < Base
      
      include Rails::Generators::Migration

      self.desc "Add all Imp::Engine migrations, give any argument to run"
      self.namespace("imp:migrations")

      def self.next_migration_number(dirname)
        "%.3d" % (current_migration_number(dirname) + 1)
      end

      def gen(dry_run = false)
        super
        create_migrations
      end

      private

      def create_migrations
        migration_files.each do |migration|
          filename = migration_name(migration)
          add_migration(File.join(self.migrations_source_root, filename), migration_klass(filename))
        end
      end

    end

  end
  
end
