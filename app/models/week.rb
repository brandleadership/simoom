class Week < ActiveRecord::Base
  
  STATE_DONE = 1
  STATE_UNDONE = 0
  
  has_many :week_todo_lists, :dependent => :destroy
  has_many :todo_lists, :through => :week_todo_lists
  
  validates :available_hours, :presence => true
  validates :nr, :uniqueness => true
  
  after_initialize do
    self.nr = Date.today.cweek if self.nr.blank?
  end
  
  def completed_hours
    todo_lists.where(:state => TodoList::STATE_DONE).inject(0) { |total, todo_list| total += todo_list.estimate.to_i }
  end
  
  def planned_hours
    todo_lists.inject(0) { |total, todo_list| total += todo_list.estimate.to_i }
  end
  
  def hours_left
    available_hours - planned_hours
  end
end
