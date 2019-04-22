require 'rails_helper'

RSpec.describe Workspace, type: :model do

  describe "#create" do
    let(:workspace) { create(:workspace) }
    subject { workspace }

    it "creates a new workspace entry" do
      expect{ workspace }.to change{ Workspace.count }.from(0).to(1)
    end
  end

  describe "#valid?" do
    let(:workspace) { build_stubbed(:workspace) }

    context "valid" do
      it "workspace" do
        assert workspace.valid?
      end

      it "without description" do
        workspace.description = nil
        assert workspace.valid?
      end
    end
  
    context "invalid" do
      it "without label" do
        workspace.label = nil
        refute workspace.valid?
      end
    
      it "with label length inferior to 3 characters" do
        workspace.label = "GO"
        refute workspace.valid?
      end
  
      it "with description < 15 characters" do
        workspace.description = "N" * 14
        refute workspace.valid?
      end

      it "with description > 500 characters" do
        workspace.description = "N" * 501
        refute workspace.valid?
      end

      it "with public attribut with non boolean type" do
        workspace.public = nil
        refute workspace.valid?
      end
    end
  end
end
