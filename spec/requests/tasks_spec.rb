require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  let!(:tasks) { create_list(:task, 5) }
  let(:task_id) { tasks.first.id }
  let(:project) { create(:project) }

  describe "GET /tasks" do
    before { get "/tasks" }

    it "returns a tasks list" do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

    it "returns a status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /tasks/:task_id
  describe "GET /tasks/:task_id" do
    before { get "/tasks/#{task_id}" }

    context "when task exists" do
      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end

      it "returns the task" do
        expect(json["id"]).to eq(task_id)
      end
    end
    
    context "when task does not exist" do
      let(:task_id) { 0 }

      it "returns a status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(response.body).to match(/Couldn't find Task/)
      end
    end
  end

  # Test suite for PUT /tasks/:task_id
  describe "POST /tasks/:task_id" do
    let(:valid_attributes) {
      {
        title: "New awesome task",
        content: "Awesome task content",
        state: "TODO",
        project_id: project.id
      }
    }

    let(:invalid_attributes) {
      {
        title: nil
      }
    }

    context "when request attributes are valid" do
      before { post "/tasks", params: { task: valid_attributes } }

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context "when an invalid request" do
      before { post "/tasks", params: { task: invalid_attributes } }

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end

      it "returns a failure message" do
        expect(response.body).to match(/can't be blank/)
      end
    end
  end

  # Test suite for PUT /tasks/:task_id
  describe "PUT /tasks/:task_id" do
    let(:valid_attributes) {
      { title: "Cool task" }
    }

    before { put "/tasks/#{task_id}", params: { task: valid_attributes } }

    context "when task exists" do
      it "returns status code 204" do
        expect(response).to have_http_status(204)
      end

      it "updates the task" do
        updated_task = Task.find(task_id)
        expect(updated_task.title).to match(/Cool task/)
      end
    end

    context "when the task does not exist" do
      let(:task_id) { 0 }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(response.body).to match(/Couldn't find Task/)
      end
    end
  end

  # Test suite for DELETE /tasks/:id
  describe "DELETE /tasks/:id" do
    before { delete "/tasks/#{task_id}" }

    it "returns status code 204" do
      expect(response).to have_http_status(204)
    end
  end

  describe "GET /task_states" do
    before { get "/task_states" }

    it "returns a status code 200" do
      expect(response).to have_http_status(200)
    end

    it "returns an array of STATES" do
      expect(response.body).to eq(Task::STATES.to_json)
    end

    it "returns the 3 existing states as list for task" do
      expect(json).not_to be_empty
      expect(json.size).to eq(3)
    end
  end
end
