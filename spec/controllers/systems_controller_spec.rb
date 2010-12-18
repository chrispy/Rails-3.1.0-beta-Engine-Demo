require 'spec_helper'

describe SystemsController do

  ## setup reachable routes, independent from real routes
  before(:all) do
    Rails.application.routes.draw do
      match "/systems" => "systems#index",   :as => :systems
      match "/system1" => "systems#system1", :as => :system1
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

  describe "GET 'system1'" do
    it "should be successful" do
      get 'system1'
      response.should be_success
    end
  end

end
