class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :locate

      t.timestamps
    end
  end
end
