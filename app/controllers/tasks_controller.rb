class TasksController < ApplicationController

  def new
    @task = Task.new
    render 'new.js.erb'
  end

  def create
    @task = Task.new(params.require(:task).permit(:title, :description))
    @task.user_id = current_user.id
    if @task.save
      @tasks = current_user.tasks
      render 'create.js.erb'
    else
      render 'shared/errors.js.erb'
    end
  end

  def edit
    @task = Task.find(params[:id])
    render 'edit.js.erb'
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(params.require(:task).permit(:title, :description))
      @tasks = current_user.tasks
      render 'update.js.erb'
    else
      render 'shared/errors.js.erb'
    end
  end

  def destroy
    Task.find(params[:id]).destroy
    render 'destroy.js.erb'
  end
end
