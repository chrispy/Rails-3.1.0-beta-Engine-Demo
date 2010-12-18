ENV["RAILS_ENV"] = "test"
require "bundler"
Bundler.setup

require File.expand_path("../spec/dummy/config/environment.rb",  __FILE__)

require 'rspec/core'
require 'rspec/core/rake_task'

require 'imp'

## do nothing dummy
task :noop do; end

## slightly adjusted rake routes task to display the engine routes via dummy rails app
namespace :rails do
  desc 'Print out all defined engine routes using dummy rails app as config helper'
  task :routes do
    all_routes = Imp::Engine.routes.routes
    routes = all_routes.collect do |route|
      reqs = route.requirements.dup
      reqs[:to] = route.app unless route.app.class.name.to_s =~ /^ActionDispatch::Routing/
      reqs = reqs.empty? ? "" : reqs.inspect
      {:name => route.name.to_s, :verb => route.verb.to_s, :path => route.path, :reqs => reqs}
    end
    name_width = routes.map{ |r| r[:name].length }.max
    verb_width = routes.map{ |r| r[:verb].length }.max
    path_width = routes.map{ |r| r[:path].length }.max
    routes.each do |r|
      puts "#{r[:name].rjust(name_width)} #{r[:verb].ljust(verb_width)} #{r[:path].ljust(path_width)} #{r[:reqs]}"
    end
  end
end
task :routes => :"rails:routes"


namespace :imp do

  namespace :rspec do
    [:requests, :models, :controllers, :views, :helpers, :mailers, :integration].each do |sub|
      desc "Run the code tests in spec/#{sub}"
      RSpec::Core::RakeTask.new(sub => :noop) do |t|
        t.pattern = "./spec/#{sub}/**/*_spec.rb"
      end
    end

    desc 'Runs all rspec tests'
    task :all => [:models, :controllers, :integration ]
    #task :all => [:requests, :models, :controllers, :views, :helpers, :mailers, :integration]
  end

end

task :default => :"imp:rspec:all"

