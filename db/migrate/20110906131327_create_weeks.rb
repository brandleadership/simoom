class CreateWeeks < ActiveRecord::Migration
  def change
    create_table :weeks do |t|
      t.integer :nr
      t.integer :available_hours
      t.boolean :done
      t.timestamps
    end
  end
end
