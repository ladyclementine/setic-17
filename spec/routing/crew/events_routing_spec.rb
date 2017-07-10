require "rails_helper"

RSpec.describe Crew::EventsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/crew/events").to route_to("crew/events#index")
    end

    it "routes to #new" do
      expect(:get => "/crew/events/new").to route_to("crew/events#new")
    end

    it "routes to #show" do
      expect(:get => "/crew/events/1").to route_to("crew/events#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/crew/events/1/edit").to route_to("crew/events#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/crew/events").to route_to("crew/events#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/crew/events/1").to route_to("crew/events#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/crew/events/1").to route_to("crew/events#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/crew/events/1").to route_to("crew/events#destroy", :id => "1")
    end

  end
end
