class WeeksTodoListsController < ApplicationController
  respond_to :js
  
  def create
    @week = Week.find(params[:week_id])
    @todo_list = TodoList.find(params[:todo_list_id])
      
    @week_todo_list = WeekTodoList.find_or_create_by_week_id_and_todo_list_id(
      @week.id,
      @todo_list.id
    )
    respond_with @week_todo_list
  end
  
  def destroy
    @week_todo_list = WeekTodoList.find(params[:id])
    @week = @week_todo_list.week
    @todo_list = @week_todo_list.todo_list
    @week_todo_list.destroy
  end
end