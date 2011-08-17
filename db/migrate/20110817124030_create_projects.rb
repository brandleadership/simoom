class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :basecamp_id
      t.string :name
      t.integer :p_number

      t.timestamps
    end
  end
end
