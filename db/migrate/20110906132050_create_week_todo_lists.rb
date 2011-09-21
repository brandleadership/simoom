class CreateWeekTodoLists < ActiveRecord::Migration
  def change
    create_table :week_todo_lists do |t|
      t.references :week
      t.references :todo_list
      t.timestamps
    end
  end
end
