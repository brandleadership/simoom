class TodoList < ActiveRecord::Base

  belongs_to :project
  has_many :todo_items

  def fetch_items
    Basecamp::TodoItem.find(:all, :params => { :todo_list_id => basecamp_id, :filter => 'all' })
  end

end
