class TasksController < ApplicationController
  def create
    @task = Task.new(params.require(:task).permit(:title, :description))
    @task.user_id = current_user.id
    if @task.save
      @tasks = current_user.tasks
      render 'create.js.erb' 
    else
      render 'new.js.erb'
    end
  end

  def destroy
    Task.find(params[:id]).destroy
    render 'destroy.js.erb'
  end
end