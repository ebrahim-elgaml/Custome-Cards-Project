class ChangeCards < ActiveRecord::Migration
  def change
  	change_column :cards, :number, :string
  end
end
