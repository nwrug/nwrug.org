class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :website
      t.string :street_address
      t.string :city
      t.string :postal_code

      t.timestamps null: false
    end
    add_index :locations, :name

    add_column :events, :location_id, :integer
    add_index :events, :location_id
  end
end
