require 'spec_helper'

describe Basecamp::TodoList do
  describe '#extract_attributes' do
    context 'without any estimates' do
      before :each do
        @basecamp_todo_list = Basecamp::TodoList.new(:id => nil, :name => nil, :description => nil, :completed => nil)
        @attributes = @basecamp_todo_list.extract_attributes
        @todo_list = ::TodoList.new(@attributes)
      end
      
      it 'does not extract estimate' do
        @todo_list.estimate.should be_nil
      end
    end
    
    context 'when estimate is available' do
      before :each do
        @basecamp_todo_list = Basecamp::TodoList.new(:id => 1, :name => 'Dummy Todo List', :description => '45h', :completed => false)
        @attributes = @basecamp_todo_list.extract_attributes
        @todo_list = ::TodoList.new(@attributes)
      end
    
      it 'extracts estimated time' do
        @attributes.should have_key(:estimate)
        @todo_list.estimate.should == 45
      end
    end
  end
end