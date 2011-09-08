class TodoListsController < ApplicationController
  respond_to :html, :js
  
  def index
    @todo_lists = params[:project_id].present? ? Project.find(params[:project_id]).todo_lists : TodoList.all
    respond_with @todo_lists
  end
end
