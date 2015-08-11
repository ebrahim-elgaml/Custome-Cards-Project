class ChangeNumberColumnNameCards < ActiveRecord::Migration
  def change
  	rename_column :cards, :number, :card_number
  end
end
