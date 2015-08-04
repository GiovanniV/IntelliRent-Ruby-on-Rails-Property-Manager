class ChangeAddressFormatProperties < ActiveRecord::Migration
  def up
    change_column :properties, :address, :string
  end

  def down
    change_column :properties, :address, :text
  end
end
