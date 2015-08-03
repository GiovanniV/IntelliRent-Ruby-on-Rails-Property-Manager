class FixProductId < ActiveRecord::Migration
  def change
    rename_column :line_items, :product_id, :property_id
  end
end
