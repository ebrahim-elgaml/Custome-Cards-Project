class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :number, :limit => 8
      t.integer :added_by_id
      t.integer :taken_by_id
      t.integer :type_id

      t.timestamps null: false
    end
  end
end
