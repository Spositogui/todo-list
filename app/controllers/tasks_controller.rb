class TasksController < ApplicationController
  before_action :set_task, only: %i[edit update destroy change_priority]
  def new
    @task = Task.new
    render 'new.js.erb'
  end

  def create
    @task = Task.new(params.require(:task).permit(:title, :description))
    @task.user_id = current_user.id
    if @task.save
      @tasks = current_user.tasks.order(:created_at)
      render 'create.js.erb'
    else
      render 'shared/errors.js.erb'
    end
  end

  def edit
    render 'edit.js.erb'
  end

  def update
    if @task.update(params.require(:task).permit(:title, :description))
      @tasks = current_user.tasks.order(:created_at)
      render 'update.js.erb'
    else
      render 'shared/errors.js.erb'
    end
  end

  def destroy
    @task.destroy
    render 'destroy.js.erb'
  end

  def change_priority
    if @task.priority != params[:priority]
      @task.update(priority: params[:priority])
    end
    @tasks = current_user.tasks.order(:created_at)
    render 'change_priority.js.erb'
  end

  private
    
    def set_task
      @task = Task.find(params[:id])
    end
end
