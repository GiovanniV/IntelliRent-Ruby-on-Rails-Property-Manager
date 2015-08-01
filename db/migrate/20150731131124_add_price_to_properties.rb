class AddPriceToProperties < ActiveRecord::Migration
  def change
  add_column :properties, :price, :decimal
  end
end
