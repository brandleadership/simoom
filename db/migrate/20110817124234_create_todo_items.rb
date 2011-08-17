class CreateTodoItems < ActiveRecord::Migration
  def change
    create_table :todo_items do |t|
      t.string :name
      t.integer :basecamp_id
      t.integer :todo_list_id

      t.timestamps
    end
  end
end
