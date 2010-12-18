require 'bundler'
require 'imp'

namespace :imp do
  def root
    Imp::Engine.find_root_with_flag("imp.gemspec")
  end

  require File.join(root, 'lib', 'generators', 'imp', 'imp')

  namespace :install do

    desc "Install Migrations"
    task :migrations do
      Rake::Task['imp:remove:migrations'].invoke
      Imp::Generators::MigrationsGenerator.new.gen
    end

    desc "Install Models"
    task :models do
      Rake::Task['imp:remove:models'].invoke
      Imp::Generators::ModelsGenerator.new.gen
    end

    desc "Install Controllers"
    task :controllers do
      Rake::Task['imp:remove:controllers'].invoke
      Imp::Generators::ControllersGenerator.new.gen
    end

    desc "Install Metals"
    task :metals do
      Rake::Task['imp:remove:metals'].invoke
      Imp::Generators::MetalsGenerator.new.gen
    end

    desc 'Installs everything the engine has to offer'
    task :all => [:migrations, :models, :controllers, :metals ]

  end


  ## Todo: find out howto remove them with the Generator itself
  namespace :remove do

    desc "Remove Migrations"
    task :migrations do
      Imp::Generators::MigrationsGenerator.new.remove
    end

    desc "Remove Models"
    task :models do
      Imp::Generators::ModelsGenerator.new.remove
    end

    desc "Remove Controllers"
    task :controllers do
      Imp::Generators::ControllersGenerator.new.remove
    end

    desc "Remove Metals"
    task :metals do
      Imp::Generators::MetalsGenerator.new.remove
    end

    desc 'remove everything the engine had to offer'
    task :all => [:migrations, :models, :controllers, :metals ]

  end

end
