require "rails_helper"

RSpec.describe ProjectsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/workspaces/1/projects").to route_to("projects#index", workspace_id: "1")
    end

    it "routes to #show" do
      expect(:get => "/workspaces/1/projects/1").to route_to("projects#show", workspace_id: "1", id: "1")
    end

    it "routes to #create" do
      expect(:post => "/workspaces/1/projects").to route_to("projects#create", workspace_id: "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "/workspaces/1/projects/1").to route_to("projects#update", workspace_id: "1", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/workspaces/1/projects/1").to route_to("projects#update", workspace_id: "1", id: "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/workspaces/1/projects/1").to route_to("projects#destroy", workspace_id: "1", id: "1")
    end
  end
end
