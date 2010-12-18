## This way they are combined under one common path
Imp::Engine.routes.draw do
  match "/graphs" => "graphs#index",  :as => :graphs
  match "/graph1" => "graphs#graph1", :as => :graph1
  ## systems#index is accessible from inside the engine, and outside
  root :to => "systems#index"
end


### This way they mix seemless into the Main App
Rails.application.routes.draw do
  ## systems#index is accessible from inside the engine, and outside
  match "/system1" => "systems#system1",   :as => :system1
end
