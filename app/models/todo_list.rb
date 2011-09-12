class TodoList < ActiveRecord::Base

  belongs_to :project
  has_many :todo_items
  
  has_many :week_todo_lists
  has_many :weeks, :through => :week_todo_lists
  
  #
  # Fetch the child items from basecamp
  #
  def fetch_items
    Basecamp::TodoItem.find(:all, :params => { :todo_list_id => basecamp_id, :filter => 'all' })
  end

  #
  # Map the child items from basecamp to local child objects
  #
  def sync(log_level = :info)
    @logger = Basecamp::ImportLogger.new(log_level)
    basecamp_items = fetch_items

    unless basecamp_items.blank?
      @logger.log :debug, "found #{basecamp_items.size} Todo Items for #{name}"
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
