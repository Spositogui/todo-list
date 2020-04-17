class HomeController < ApplicationController
  def index
    @tasks = current_user.tasks.order(:created_at) if user_signed_in?
    @task = Task.new
  end
end
