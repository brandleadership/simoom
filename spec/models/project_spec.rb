require 'spec_helper'

describe Project do

  describe '#fetch_items' do

    it 'fetches all todo_lists of the project' do
      Basecamp::TodoList.should_receive(:find)
      Project.new(:basecamp_id => 1).fetch_items
    end

    it 'returns all non excluded items as an array' do
      VCR.use_cassette('lists_for_project', :record => :new_episodes) do
        Project.new(:basecamp_id => 7809235).fetch_items.size.should be 0
      end
    end
    
    it 'returns all items regardless if flagged as excluded' do
      VCR.use_cassette('lists_for_project', :record => :new_episodes) do
        Project.new(:basecamp_id => 7809235).fetch_items(:exclude => false).size.should be 1
      end
    end
  end

  describe '#sync' do

    before :each do
      @project = Project.new(:basecamp_id => 7809235)
    end

    it 'fetches the todo lists from basecamp' do
      VCR.use_cassette('lists_for_project', :record => :new_episodes) do
        @project.should_receive(:fetch_items)
        @project.sync
      end
    end

    it 'maps the basecamp items to local child objects' do
      VCR.use_cassette('lists_for_project', :record => :new_episodes) do
        @project.sync
        @project.todo_lists.each { |e| e.should be_a TodoList }
        @project.todo_lists.each { |e| e.state.should_not be_nil }
      end
    end

    it 'syncs recursively on every todo_list' do
      VCR.use_cassette('lists_for_project', :record => :new_episodes) do
        @project.sync
        @project.todo_lists.each { |e| e.todo_items.should_not be_blank }
      end
    end
  end
  
  describe '.by_name' do
    it 'returns all projects ordered by name' do
      Project.should respond_to(:by_name)
    end
  end
end
