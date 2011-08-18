require 'spec_helper'

describe Basecamp::Importer do

  describe '.perform' do

    it 'syncs the relevant data' do
      VCR.use_cassette('projects_tree', :record => :new_episodes) do
        silence(:stdout) { Basecamp::Importer.perform }
      end

      Project.all.size.should be 14
      TodoList.all.size.should be 90
      TodoItem.all.size.should be 393
    end

  end
end
