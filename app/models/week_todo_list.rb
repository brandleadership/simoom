class WeekTodoList < ActiveRecord::Base
  belongs_to :week
  belongs_to :todo_list
end
