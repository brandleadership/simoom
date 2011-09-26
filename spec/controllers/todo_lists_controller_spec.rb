require 'spec_helper'

describe TodoListsController do

  describe "GET 'index'" do
    it "should be successful" do
      pending
      get 'index'
      response.should be_success
    end
  end

  describe "PUT '/weeks_todo_lists/:id'" do
    context 'when marking a todo list as done' do
      it 'completes the todo_list in basecamp' do
        mock_todo_list = mock_model(TodoList, :update_attributes => true)
        week = Factory.create(:week)
        TodoList.should_receive(:find).with("1").and_return(mock_todo_list)
        mock_todo_list.should_receive(:complete_in_basecamp)
        put :update, :id => 1, :week_id => week.id, :todo_list => { :state => TodoList::STATE_DONE }, :format => :js
      end
    end
  end

end
