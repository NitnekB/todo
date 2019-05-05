require 'rails_helper'

RSpec.describe Task, type: :model do

  subject { task }

  describe "#create" do
    let(:task) { create(:task) }

    it "creates a new task entry from factory" do
      expect{ subject }.to change{ Task.count }.by(1)
    end
  end

  describe "#valid?" do
    let(:task) { build_stubbed(:task) }
    
    context "valid" do
      it "task" do
        expect(subject).to be_valid
      end

      describe "STATES array" do
        it "if task state equal TODO" do
          task.state = "TODO"
          expect(subject).to be_valid
        end

        it "if task state equal DOING" do
          task.state = "DOING"
          expect(subject).to be_valid
        end

        it "if task state equal DONE" do
          task.state = "DONE"
          expect(subject).to be_valid
        end
      end
    end
    
    context "invalid" do
      it "without title" do
        task.title = nil
        expect(subject).not_to be_valid
      end

      it "with title under 3 characters" do
        task.title = "NO"
        expect(subject).not_to be_valid
      end

      it "without state" do
        task.state = nil
        expect(subject).not_to be_valid
      end

      it "with state which is not in the STATES array" do
        task.state = "TO_ESTIMATE"
        expect(subject).not_to be_valid
      end
    end
  end
end
