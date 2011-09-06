class Week < ActiveRecord::Base
  has_many :week_todo_items
  has_many :todo_items, :through => :week_todo_items
  
  def completed_hours
    0
  end
  
  def planned_hours
    0
  end
end
