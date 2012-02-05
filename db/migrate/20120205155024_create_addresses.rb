class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :line_1
      t.string :line_2
      t.string :city
      t.string :state
      t.string :country
      t.string :zip
      t.string :longitude
      t.string :latitude
      t.integer :addressable_id
      t.string :addressable_type
      t.timestamps
    end
    add_index :addresses, [:addressable_type, :addressable_id]
  end
end
