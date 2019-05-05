require 'rails_helper'

RSpec.describe Workspace, type: :model do

  subject { workspace }

  describe "#create" do
    let(:workspace) { create(:workspace) }

    it "creates a new workspace entry from factory" do
      expect{ subject }.to change{ Workspace.count }.by(1)
    end
  end

  describe "#valid?" do
    let(:workspace) { build_stubbed(:workspace) }

    context "valid" do
      it "workspace" do
        expect(subject).to be_valid
      end

      it "without description" do
        workspace.description = nil
        expect(subject).to be_valid
      end
    end
  
    context "invalid" do
      it "without label" do
        workspace.label = nil
        expect(subject).not_to be_valid
      end
    
      it "with label length inferior to 3 characters" do
        workspace.label = "GO"
        expect(subject).not_to be_valid
      end
  
      it "with description < 15 characters" do
        workspace.description = "N" * 14
        expect(subject).not_to be_valid
      end

      it "with description > 500 characters" do
        workspace.description = "N" * 501
        expect(subject).not_to be_valid
      end

      it "with public attribut with non boolean type" do
        workspace.public = nil
        expect(subject).not_to be_valid
      end
    end
  end
end
