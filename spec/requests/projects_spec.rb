require 'rails_helper'

RSpec.describe "Projects", type: :request do
  let(:workspace) { create(:workspace) }
  let(:projects) { create_list(:project, 10, workspace_id: workspace.id) }

  let(:workspace_id) { workspace.id }
  let(:id) { projects.first.id }

  describe "GET /workspaces/:workspace_id/projects" do
    before { projects }

    before { get "/workspaces/#{workspace_id}/projects" }

    context "when workspace exists" do
      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end

      it "returns all workspace projects" do
        expect(json).not_to be_empty
        expect(json.size).to eq(10)
      end
    end

    context "when workspace does not exist" do
      let(:workspace_id) { 0 }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(response.body).to match(/Couldn't find Workspace/)
      end
    end
  end

  # Test suite for GET /workspaces/:workspace_id/projects/:id
  describe "GET /workspaces/:workspace_id/projects/:id" do
    before { projects }

    before { get "/workspaces/#{workspace_id}/projects/#{id}" }

    context "when workspace project exists" do
      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end

      it "returns the project" do
        expect(json["id"]).to eq(id)
      end
    end

    context "when workspace project does not exist" do
      let(:id) { 0 }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(response.body).to match(/Couldn't find Project/)
      end
    end
  end

  # Test suite for PUT /workspaces/:workspace_id/projects
  describe "POST /workspaces/:workspace_id/projects" do
    let(:valid_attributes) {
      {
        title: "New awesome project",
        description: "Awesome project about projects"
      }
    }

    let(:invalid_attributes) {
      {
        title: "NO"
      }
    }

    context "when request attributes are valid" do
      before { post "/workspaces/#{workspace_id}/projects", params: { project: valid_attributes } }

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context "when an invalid request" do
      before { post "/workspaces/#{workspace_id}/projects", params: { project: invalid_attributes } }

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end

      it "returns a failure message" do
        expect(response.body).to match(/is invalid/)
      end
    end
  end

  # Test suite for PUT /workspaces/:workspace_id/projects/:id
  describe "PUT /workspaces/:workspace_id/projects/:id" do
    let(:valid_attributes) {
      { title: "Cool project" }
    }

    before { put "/workspaces/#{workspace_id}/projects/#{id}", params: { project: valid_attributes } }

    context "when project exists" do
      it "returns status code 204" do
        expect(response).to have_http_status(204)
      end

      it "updates the project" do
        updated_project = Project.find(id)
        expect(updated_project.title).to match(/Cool/)
      end
    end

    context "when the project does not exist" do
      let(:id) { 0 }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(response.body).to match(/Couldn't find Project/)
      end
    end
  end

  # Test suite for DELETE /workspaces/:id
  describe "DELETE /workspaces/:id" do
    before { delete "/workspaces/#{workspace_id}/projects/#{id}" }

    it "returns status code 204" do
      expect(response).to have_http_status(204)
    end
  end
end
