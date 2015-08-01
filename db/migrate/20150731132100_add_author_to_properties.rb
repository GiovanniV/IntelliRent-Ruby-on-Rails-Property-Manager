class AddAuthorToProperties < ActiveRecord::Migration
  def change
  add_column :properties, :author, :string
  end
  add_index :properties, :available_on
end
