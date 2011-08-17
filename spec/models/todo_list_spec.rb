require 'spec_helper'

describe TodoList do

  describe '#fetch_items' do

    it 'fetches all todo_items in the list' do
      Basecamp::TodoItem.should_receive(:find)
      TodoList.new(:basecamp_id => 1).fetch_items
    end

    it 'returns the items as an array' do
      VCR.use_cassette('items_for_list', :record => :new_episodes) do
        TodoList.new(:basecamp_id => 12574902).fetch_items.size.should be 10
      end
    end

  end
end
