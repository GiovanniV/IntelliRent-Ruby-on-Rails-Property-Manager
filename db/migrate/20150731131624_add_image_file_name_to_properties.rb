class AddImageFileNameToProperties < ActiveRecord::Migration
  def change
  add_column :properties, :image_file_name, :string
  end
  add_index :properties, :featured
end
