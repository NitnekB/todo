class TasksController < ApplicationController
  before_action :set_task, only: [:show, :update, :destroy]

  # GET /tasks
  def index
    @tasks = Task.all
    json_response(@tasks)
  end

  # GET /tasks/1
  def show
    json_response(@task)
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)

    if @task.save
      json_response(@task, :created, @task)
    else
      json_response(@task.errors, :unprocessable_entity)
    end
  end

  # PATCH/PUT /tasks/1
  def update
    if @task.update(task_params)
      json_response(@task, :no_content)
    else
      json_response(@task.errors, :unprocessable_entity)
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def task_params
      params.require(:task).permit(:title, :content, :state, :project_id)
    end
end
