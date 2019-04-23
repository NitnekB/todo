require 'rails_helper'

RSpec.describe "Projects", type: :request do
  let(:project) { create(:project) }

  describe "GET /workspaces/{#workspace_id}/projects" do
    before(:each) do
      project
      get "/workspaces/#{project.workspace.id}/projects"
    end

    it "returns one project on the first workspace" do
      expect(json).not_to be_empty
      expect(json.size).to eq(1)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end
end
