class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.integer :user_id
      t.string :title
      t.text :description
      t.string :time_start
      t.string :area
      t.string :categori
      t.string :salary
      t.integer :status
      t.string :keyword
      t.text :comment

      t.timestamps
    end
  end
end
