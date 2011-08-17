class CreateTodoLists < ActiveRecord::Migration
  def change
    create_table :todo_lists do |t|
      t.integer :basecamp_id
      t.integer :project_id
      t.integer :estimate
      t.string :name
      t.string :state

      t.timestamps
    end
  end
end
