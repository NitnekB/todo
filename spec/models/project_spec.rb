require 'rails_helper'

RSpec.describe Project, type: :model do

  subject { project }

  describe "#create" do
    let(:project) { create(:project) }

    it "creates a new project entry from factory" do
      expect{ subject }.to change{ Project.count }.by(1)
    end
  end

  describe "#valid?" do
    let(:project) { build_stubbed(:project) }

    context "valid" do
      it "project" do
        expect(subject).to be_valid
      end
    end

    context "invalid" do
      it "without title" do
        project.title = nil
        expect(subject).not_to be_valid
      end

      it "with title under 3 characters" do
        project.title = "GO"
        expect(subject).not_to be_valid
      end

      it "without any workspace" do
        project.workspace = nil
        expect(subject).not_to be_valid
      end
    end
  end
end
