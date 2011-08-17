class TodoList < ActiveRecord::Base

  belongs_to :project
  has_many :todo_items

  #
  # Fetch the child items from basecamp
  #
  def fetch_items
    Basecamp::TodoItem.find(:all, :params => { :todo_list_id => basecamp_id, :filter => 'all' })
  end

  #
  # Map the child items from basecamp to local child objects
  #
  def sync
    basecamp_items = fetch_items

    unless basecamp_items.blank?
      todo_items << basecamp_items.map do |item|
        item_attributes = {
          :basecamp_id => item.id,
          :name => item.content
        }

        ::TodoItem.find_or_initialize_by_basecamp_id(item.id, item_attributes)
      end
    end
  end
end
