class AddAvailableOnToProperties < ActiveRecord::Migration
  def change
  add_column :properties, :available_on, :date
  end
end
