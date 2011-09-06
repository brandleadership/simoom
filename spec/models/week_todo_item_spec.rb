require 'spec_helper'

describe WeekTodoItem do
  before do
    @week_todo_item = WeekTodoItem.new
  end
  
  it 'has a week' do
    @week_todo_item.should respond_to(:week)
  end
  
  it 'has a todo item' do
    @week_todo_item.should respond_to(:todo_item)
  end
end
