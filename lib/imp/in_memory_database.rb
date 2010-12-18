def enabled_memory_database?
  if ENV["RAILS_ENV"] == "test" && Rails.configuration.database_configuration['test']['database'] == ":memory:"
    if ActiveRecord::Base.connection.class == ActiveRecord::ConnectionAdapters::SQLite3Adapter
      return true
    end
  end
  false
end

if enabled_memory_database?
  ActiveRecord::Migration.verbose = false
  ActiveRecord::Base.establish_connection( Rails.configuration.database_configuration['test'])
  ActiveRecord::Migrator.migrate File.expand_path( File.join( Imp.root, 'spec', 'dummy', 'db', 'migrate') )
end


