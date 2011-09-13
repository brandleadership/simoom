class TodoListsController < ApplicationController
  respond_to :html, :js
  
  def index
    @project = Project.find(params[:todo_lists][:project_id]) rescue nil
    @week = Week.find(params[:week_id])
    
    @todo_lists = @project.present? ? todo_lists_without_week_for_project(@week, @project) : TodoList.all
    respond_with @todo_lists
  end
  
  private
    def todo_lists_without_week_for_project(week, project)
      project.todo_lists.reject do |item|
        week.todo_list_ids.include? item.id
      end
    end
end