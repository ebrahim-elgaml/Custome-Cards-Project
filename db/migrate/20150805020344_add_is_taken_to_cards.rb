class AddIsTakenToCards < ActiveRecord::Migration
  def change
    add_column :cards, :is_taken, :boolean, :default => false
  end
end
