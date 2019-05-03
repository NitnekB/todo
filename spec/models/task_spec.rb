require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "#create" do
    let(:task) { create(:task) }

    subject { task }

    it "creates a new task entry" do
      expect{ task }.to change{ Task.count }.by 1
    end

    describe "#valid?" do
      let(:task) { build_stubbed(:task) }
      
      context "valid" do
        it "task" do
          assert task.valid?
        end

        describe "STATES array" do
          it "if task state equal TODO" do
            task.state = "TODO"
            assert task.valid?
          end

          it "if task state equal DOING" do
            task.state = "DOING"
            assert task.valid?
          end

          it "if task state equal DONE" do
            task.state = "DONE"
            assert task.valid?
          end
        end
      end
      
      context "invalid" do
        it "without title" do
          task.title = nil
          refute task.valid?
        end

        it "with title under 3 characters" do
          task.title = "NO"
          refute task.valid?
        end

        it "without state" do
          task.state = nil
          refute task.valid?
        end

        it "with state which is not in the STATES array" do
          task.state = "TO_ESTIMATE"
          refute task.valid?
        end
      end
    end
  end
end
