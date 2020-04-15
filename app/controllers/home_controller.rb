class HomeController < ApplicationController
  def index
    @tasks = current_user.tasks if user_signed_in?
    @task = Task.new
  end
end
