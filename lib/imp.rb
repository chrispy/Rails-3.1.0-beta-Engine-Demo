require 'pathname'
require "active_support/dependencies/autoload"

## seems AS takes care of all this, finally...
#require 'active_support/core_ext/logger'
#require 'active_support/core_ext/class/attribute'
#require 'active_support'
#require 'action_dispatch'
#require 'active_record'
#require 'active_model'
#require 'arel'
#require 'abstract_controller'
#require 'action_controller'
#require 'action_controller/base'
#require "action_controller/metal"

module Imp
  extend ActiveSupport::Autoload

  ## Store root path of engine
  mattr_accessor :root
  self.root = File.join( File.dirname(__FILE__), ".." )

  def self.clean_filename(path)
    path.basename.to_s.gsub(/\.rb\z/, "")
  end

  ## first loads <dir>/base.rb, then the remaining files
  ## there has to be some smoother solution, somewhere...
  def self.require_subdir_with_base(dir)
    path = File.join(root, 'lib', dir)
    require Pathname.new( File.join(path, "base") ) 
    Dir.glob( File.join( path, "*.rb") ).each do |file|
      path = Pathname.new(file)
      next if clean_filename(path) == 'base'
      require path.realpath
    end
  end

  require_subdir_with_base 'imp/models'
  require_subdir_with_base 'imp/controllers'
  require_subdir_with_base 'imp/metals'
  require 'imp/helpers/application_helper'
  require 'imp/ruby_version_check'
  require 'imp/engine'
  
end

