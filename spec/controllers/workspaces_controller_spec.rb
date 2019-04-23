require 'rails_helper'

RSpec.describe WorkspacesController, type: :controller do

  let(:workspace) { create(:workspace) }

  before(:each) do
    workspace
  end

  # This should return the minimal set of attributes required to create a valid
  # Workspace. As you add validations to Workspace, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      label: "Private",
      description: "Private workspace",
      context: "Pro",
      public: false
    }
  }

  let(:invalid_attributes) {
    {
      label: nil,
      public: "wrong type"
    }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # WorkspacesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: workspace.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Workspace" do
        expect {
          post :create, params: { workspace: valid_attributes }, session: valid_session
        }.to change(Workspace, :count).by(1)
      end

      it "renders a JSON response with the new workspace" do
        post :create, params: { workspace: valid_attributes }, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(workspace_url(Workspace.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new workspace" do
        post :create, params: { workspace: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          label: "Personal"
        }
      }

      it "updates the requested workspace" do
        put :update, params: { id: workspace.to_param, workspace: new_attributes }, session: valid_session
        workspace.reload
        expect(workspace.label).to eq "Personal"
      end

      it "updates the workspace" do
        put :update, params: { id: workspace.to_param, workspace: valid_attributes }, session: valid_session
        expect(response).to have_http_status(:no_content)
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the workspace" do
        put :update, params: { id: workspace.to_param, workspace: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested workspace" do
      expect {
        delete :destroy, params: { id: workspace.to_param }, session: valid_session
      }.to change(Workspace, :count).by(-1)
    end
  end
end
