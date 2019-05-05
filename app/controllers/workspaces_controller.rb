class WorkspacesController < ApplicationController
  before_action :set_workspace, only: [:show, :update, :destroy]

  # GET /workspaces
  def index
    @workspaces = Workspace.all

    json_response(@workspaces)
  end

  # GET /workspaces/1
  def show
    json_response(@workspace)
  end

  # POST /workspaces
  def create
    @workspace_builder = WorkspaceBuilder.new(workspace_params.to_h)

    if @workspace_builder.workspace.save
      if @workspace_builder.set_default_project(@workspace_builder.workspace.id).save
        json_response(@workspace, :created, @workspace_builder.workspace)
      end
    end
  rescue => e
    json_response(e.message, :unprocessable_entity)
  end

  # PATCH/PUT /workspaces/1
  def update
    if @workspace.update(workspace_params)
      json_response(@workspace, :no_content)
    else
      json_response(@workspace.errors, :unprocessable_entity)
    end
  end

  # DELETE /workspaces/1
  def destroy
    @workspace.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workspace
      @workspace = Workspace.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def workspace_params
      params.require(:workspace).permit(:label, :description, :context, :public)
    end
end
