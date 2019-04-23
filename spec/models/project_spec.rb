require 'rails_helper'

RSpec.describe Project, type: :model do
  describe "#create" do
    let(:project) { create(:project) }

    subject { project }

    it "creates a new workspace entry" do
      expect{ project }.to change{ Project.count }.from(0).to(1)
    end

    describe "#valid?" do
      let(:project) { build_stubbed(:project) }

      context "valid" do
        it "project" do
          assert project.valid?
        end
      end

      context "invalid" do
        it "without title" do
          project.title = nil
          refute project.valid?
        end

        it "with title under 3 characters" do
          project.title = "GO"
          refute project.valid?
        end

        it "without any workspace" do
          project.workspace = nil
          refute project.valid?
        end
      end
    end
  end
end
