class AddCountryToProperties < ActiveRecord::Migration
  def change
  add_column :properties, :country, :string
  add_column :properties, :state, :string
  add_column :properties, :city, :string
  add_column :properties, :zipcode, :string
  end
end
