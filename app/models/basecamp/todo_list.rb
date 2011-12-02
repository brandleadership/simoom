module Basecamp
  class TodoList < Basecamp::Base
    
    
    def extract_attributes
      {
        :basecamp_id => id,
        :name => name,
        :estimate => (description.present? ? description.scan(Basecamp::Importer::ESTIMATE_MATCHER).flatten.first : nil),
        :state => (completed ? ::TodoList::STATE_DONE : ::TodoList::STATE_UNDONE),
        :position => position
      }
    end
  end
end
