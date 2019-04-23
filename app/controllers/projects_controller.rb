class ProjectsController < ApplicationController
  before_action :set_workspace
  before_action :set_workspace_project, only: [:show, :update, :destroy]

  # GET /projects
  def index
    json_response(@workspace.projects)
  end

  # GET /projects/1
  def show
    json_response(@project)
  end

  # POST /projects
  def create
    @workspace.projects.create!(project_params)

    if @workspace.save
      json_response(@workspace, :created)
    else
      json_response(@workspace, :unprocessable_entity)
    end
  end

  # PATCH/PUT /projects/1
  def update
    if @project.update(project_params)
      json_response(@project, :no_content)
    else
      json_response(@project, :unprocessable_entity)
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workspace
      @workspace = Workspace.find(params[:workspace_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_workspace_project
      @project = @workspace.projects.find_by!(id: params[:id]) unless @project
    end

    # Only allow a trusted parameter "white list" through.
    def project_params
      params.require(:project).permit(:title, :description, :workspace_id)
    end
end
