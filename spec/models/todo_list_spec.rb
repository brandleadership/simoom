require 'spec_helper'

describe TodoList do

  describe '#fetch_items' do

    it 'fetches all todo_items in the list' do
      Basecamp::TodoItem.should_receive(:find)
      TodoList.new(:basecamp_id => 1).fetch_items
    end

    it 'returns the items as an array' do
      VCR.use_cassette('items_for_list', :record => :new_episodes) do
        TodoList.new(:basecamp_id => 15703209).fetch_items.size.should be 4
      end
    end

  end

  describe '#sync' do

    before :each do
      @list = TodoList.new(:basecamp_id => 15703209)
    end

    it 'fetches the items from basecamp' do
      VCR.use_cassette('items_for_list', :record => :new_episodes) do
        @list.should_receive(:fetch_items)
        @list.sync
      end
    end

    it 'maps the basecamp items to local child objects' do
      VCR.use_cassette('items_for_list', :record => :new_episodes) do
        @list.sync
        @list.todo_items.each { |e| e.should be_a TodoItem }
      end
    end

  end
  
  it 'has weeks' do
    TodoList.new.should respond_to(:weeks)
  end
end
