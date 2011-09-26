require 'spec_helper'

describe TodoItem do

  describe '#complete_in_basecamp' do
    it 'marks the todo_lists items as complete in basecamp' do
      basecamp_todo_double = mock_model(Basecamp::TodoItem, :save => true)
      todo_list = Factory(:todo_list)
      todo_list.todo_items << TodoItem.new(:basecamp_id => 1)
      todo_list.should_receive(:fetch_items).and_return([basecamp_todo_double])
      basecamp_todo_double.should_receive(:completed=).with(true)
      todo_list.complete_in_basecamp
    end
  end

end
