class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :title
      t.text :address
      t.string :rent
      t.string :deposit
      t.string :lease
      t.integer :pets
      t.integer :utilities
      t.text :description
      t.string :avail
      t.string :parking
      t.string :squarefeet

      t.timestamps
    end
  end
end
