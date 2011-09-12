class WeeksTodoListsController < ApplicationController
  respond_to :js
  
  def create
    week_todo_list = WeekTodoList.find_or_create_by_week_id_and_todo_list_id(
      params[:week_todo_list][:week_id],
      params[:week_todo_list][:todo_list_id]
    )
    # TODO: What should we do here?
    # Remove from right col list
    # Add to Week list
    render :text => ''
  end
end
