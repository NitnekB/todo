require 'rails_helper'

RSpec.describe "Workspaces", type: :request do
  let!(:workspaces) { create_list(:workspace, 5) }
  let(:workspace_id) { workspaces.first.id }

  describe "GET /workspaces" do
    before { get "/workspaces" }

    it "returns workspaces" do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /workspaces/:workspace_id
  describe "GET /workspaces/:workspace_id" do
    before { get "/workspaces/#{workspace_id}" }

    context "when workspace exists" do
      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end

      it "returns the workspace" do
        expect(json["id"]).to eq(workspace_id)
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

  # Test suite for POST /workspaces
  describe "POST /workspaces" do
    let(:valid_attributes) {
      {
        label: "New awesome workspace",
        description: "Awesome workspace with projects",
        public: false
      }
    }

    let(:invalid_attributes) {
      {
        label: nil
      }
    }

    context "when request attributes are valid" do
      before { post "/workspaces", params: { workspace: valid_attributes } }

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context "when an invalid request" do
      before { post "/workspaces", params: { workspace: invalid_attributes } }

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end

      it "returns a failure message" do
        expect(response.body).to match(/can't be blank/)
      end
    end
  end

  # Test suite for PUT /workspaces/:workspace_id
  describe "PUT /workspaces/:workspace_id" do
    let(:valid_attributes) {
      { label: "Cool workspace" }
    }

    before { put "/workspaces/#{workspace_id}", params: { workspace: valid_attributes } }

    context "when workspace exists" do
      it "returns status code 204" do
        expect(response).to have_http_status(204)
      end

      it "updates the workspace" do
        updated_workspace = Workspace.find(workspace_id)
        expect(updated_workspace.label).to match(/Cool/)
      end
    end

    context "when the workspace does not exist" do
      let(:workspace_id) { 0 }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(response.body).to match(/Couldn't find Workspace/)
      end
    end
  end

  # Test suite for DELETE /workspaces/:id
  describe "DELETE /workspaces/:workspace_id" do
    before { delete "/workspaces/#{workspace_id}" }

    it "returns status code 204" do
      expect(response).to have_http_status(204)
    end
  end
end
