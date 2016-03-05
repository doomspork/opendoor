class CreateTables < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.decimal :bathrooms
      t.decimal :lat
      t.decimal :lng
      t.integer :bedrooms
      t.integer :price
      t.integer :sq_ft
      t.string :status
      t.string :street

      t.timestamps
    end
  end
end
