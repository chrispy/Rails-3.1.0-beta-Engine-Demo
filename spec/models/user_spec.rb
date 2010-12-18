require 'spec_helper'

describe User do

  it { should be_present }

  it { should be_a(Imp::ModelMethods::User) }

  it { should be_a(ActiveRecord::Base) }

end