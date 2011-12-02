class TodoListsController < ApplicationController

  respond_to :html, :js

  def index
    @project = Project.find(params[:todo_lists][:project_id]) rescue nil
    @week = Week.find(params[:week_id])

    @todo_lists = @project.present? ? todo_lists_without_week_for_project(@week, @project) : TodoList.all.by_position
    respond_with @todo_lists
  end

  def update
    todo_list = TodoList.find(params[:id])

    if params[:todo_list][:state] == TodoList::STATE_DONE.to_s
      todo_list.complete_in_basecamp
    end

    if todo_list.update_attributes(params[:todo_list])
      @week = Week.find(params[:week_id])
      @todo_lists = @week.todo_lists
    end
  end

private

  def todo_lists_without_week_for_project(week, project)
    project.todo_lists.by_position.uncomplete.reject do |item|
      week.todo_list_ids.include? item.id
    end
  end

end
