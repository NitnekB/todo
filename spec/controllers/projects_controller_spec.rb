require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

  let(:workspace) { create(:workspace) }
  let(:project) { create(:project, workspace: workspace) }

  before(:each) do
    workspace
    project
  end

  let(:valid_attributes) {
    attributes_for(:project).merge(workspace_id: workspace.id)
  }

  let(:invalid_attributes) {
    attributes_for(:project, title: "NO", workspace_id: nil)
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: { workspace_id: workspace.id }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { workspace_id: workspace.id, id: project.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Project" do
        expect {
          post :create, params: { workspace_id: workspace.id, project: valid_attributes }, session: valid_session
        }.to change(Project, :count).by(1)
      end

      it "renders a JSON response with the new project" do
        post :create, params: { workspace_id: workspace.id, project: valid_attributes }, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new project" do
        post :create, params: { workspace_id: workspace.id, project: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { title: "New title" }
      }

      it "updates the requested project" do
        put :update, params: { workspace_id: workspace.id, id: project.to_param, project: new_attributes }, session: valid_session
        project.reload
        expect(project.title).to eq "New title"
      end

      it "renders a JSON response with the project" do
        put :update, params: { workspace_id: workspace.id, id: project.to_param, project: valid_attributes }, session: valid_session
        expect(response).to have_http_status(:no_content)
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the project" do
        put :update, params: { workspace_id: workspace.id, id: project.to_param, project: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested project" do
      expect {
        delete :destroy, params: { workspace_id: workspace.id, id: project.to_param }, session: valid_session
      }.to change(Project, :count).by(-1)
    end
  end
end
