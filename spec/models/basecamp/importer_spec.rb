require 'spec_helper'

describe Basecamp::Importer do

  describe '.perform' do

    it 'syncs the relevant data' do
      VCR.use_cassette('projects_tree', :record => :new_episodes) do
        silence(:stdout) { Basecamp::Importer.perform }
      end

      Project.all.size.should be 2
      TodoList.all.size.should be 3
      TodoItem.all.size.should be 10
    end

  end
end
