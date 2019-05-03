require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "#create" do
    let(:task) { create(:task) }

    subject { task }

    it "creates a new task entry" do
      expect{ task }.to change{ Task.count }.by 1
    end

    describe "#valid" do
      it "task" do
        assert task.valid?
      end
    end
  end
end
