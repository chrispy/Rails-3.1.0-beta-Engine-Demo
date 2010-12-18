require 'spec_helper'

describe System do

  it { should be_present }

  it { should be_a(Imp::ModelMethods::System) }

  it { should_not be_a(ActiveRecord::Base) }

end