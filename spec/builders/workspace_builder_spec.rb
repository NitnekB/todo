require 'rails_helper'

RSpec.describe WorkspaceBuilder, type: :builder do
  let(:label) { "Private" }
  let(:description) { "Private workspace" }
  let(:context) { nil }
  let(:public) { false }

  let(:params) {
    {
      label: label,
      description: description,
      context: context,
      public: public
    }
  }

  subject { WorkspaceBuilder.new(params) }

  describe "#new" do
    context "with valid parameters" do
      it "set a workspace attribute referring to Workspace Class" do
        expect(subject).to respond_to(:workspace)
        expect(subject.workspace).to be_a_new(Workspace)
      end

      it "build a new workspace" do
        expect(subject.workspace).to be_valid
      end
    end

    context "with invalid parameters" do
      let(:params) { { title: nil } }

      it "is not valid with incorrect params" do  
        expect{ subject.workspace }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#set_label" do
    context "with valid value" do
      let(:label) { "Valid label" }

      it "assigns the correct value" do
        expect(subject.workspace.label).to eq "Valid label"
      end
    end
    
    context "with invalid value" do
      describe "cannot be nil" do
        let(:label) { nil }

        it "raises a require error" do
          expect{ subject.workspace }.to raise_error(ArgumentError, "Label is required and can't be blank")
        end
      end

      describe "cannot be under 3 characters" do
        let(:label) { "NO" }
        it "raises a too short error" do
          expect{ subject.workspace }.to raise_error(ArgumentError, "Label is too short. It must have a least 3 characters")
        end
      end
    end
  end

  describe "#set_description" do
    context "with valid value" do
      let(:description) { "Valid description for this workspace" }

      it "assigns the correct value" do
        expect(subject.workspace.description).to eq "Valid description for this workspace"
      end
    end

    context "with invalid value" do
      describe "cannot be under 15 characters" do
        let(:description) { "X" * 14 }

        it "raises a too short error" do
          expect{ subject.workspace }.to raise_error(ArgumentError, "Description is too short. It must have a least 15 characters")
        end
      end
      
      describe "cannot be above 256 characters" do
        let(:description) { "X" * 257 }

        it "raises a too long error" do
          expect{ subject.workspace }.to raise_error(ArgumentError, "Description is too long. It can't have more than 256 characters")
        end
      end
    end
  end  

  describe "#set_public" do
    context "with valid value" do
      let(:public) { "true" }

      it "assigns the correct value" do
        expect(subject.workspace.public).to eq true
      end
    end

    context "with invalid value" do
      let(:public) { "truth" }

      it "raises a type error" do
        expect{ subject.workspace }.to raise_error(ArgumentError, "Public must be a boolean")
      end
    end
  end

  describe "#set_default_project" do
    let(:workspace) { create(:workspace) }

    it "build a new default project" do
      expect(subject.set_default_project(workspace.id)).to be_a_new(Project)
    end

    it "build a valid object" do
      expect(subject.set_default_project(workspace.id)).to be_valid
    end
  end
end
