require 'spec_helper'

describe Basecamp::Importer do

  describe '.perform' do
    before :each do
      VCR.use_cassette('projects_tree', :record => :new_episodes) do
        silence(:stdout) { Basecamp::Importer.perform }
      end
    end

    it 'syncs the relevant data' do
      Project.all.size.should be 2
      TodoList.all.size.should be 3
      TodoItem.all.size.should be 10
    end
    
    it 'initializes all project with a status' do
      Project.all.each { |project| project.status.should_not be_nil}
    end

  end
end
