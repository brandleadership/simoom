class WeekTodoItem < ActiveRecord::Base
  belongs_to :week
  belongs_to :todo_item
end
