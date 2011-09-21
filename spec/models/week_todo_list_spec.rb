require 'spec_helper'

describe WeekTodoList do
  before do
    @week_todo_list = WeekTodoList.new
  end
  
  it 'has a week' do
    @week_todo_list.should respond_to(:week)
  end
  
  it 'has a todo item' do
    @week_todo_list.should respond_to(:todo_list)
  end
end
