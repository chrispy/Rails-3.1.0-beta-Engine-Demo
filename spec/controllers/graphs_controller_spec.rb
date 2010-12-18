require 'spec_helper'

describe GraphsController do

  ## setup reachable routes, independent from real routes
  before(:all) do
    Rails.application.routes.draw do
      match "/graphs" => "graphs#index",  :as => :graphs
      match "/graph1" => "graphs#graph1", :as => :graph1
    end
  end

  after(:all) do
    Rails.application.reload_routes!
  end

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'graph1'" do
    it "should be successful" do
      get 'graph1'
      response.should be_success
    end
  end

end
