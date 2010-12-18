require 'spec_helper'

describe Imp do
  
  it "should be a valid module" do
    Imp.should be_a(Module)
  end

  it "should include a valid engine" do
    Imp::Engine.should be_a(Module)
  end

end