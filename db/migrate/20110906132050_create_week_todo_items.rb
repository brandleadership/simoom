class CreateWeekTodoItems < ActiveRecord::Migration
  def change
    create_table :week_todo_items, :id => false do |t|
      t.references :week
      t.references :todo_item
      t.timestamps
    end
  end
end
