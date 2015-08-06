class AddTakenAtToCards < ActiveRecord::Migration
  def change
    add_column :cards, :taken_at, :datetime
  end
end
