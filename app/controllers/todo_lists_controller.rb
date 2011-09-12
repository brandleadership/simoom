class TodoListsController < ApplicationController
  respond_to :html, :js
  
  def index
    project_id = params[:todo_lists][:project_id].presence if params[:todo_lists].present?
    @todo_lists = project_id ? Project.find(project_id).todo_lists : TodoList.all
    respond_with @todo_lists
  end
end
