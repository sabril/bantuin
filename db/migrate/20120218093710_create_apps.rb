class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.integer :job_id
      t.integer :user_id
      t.string :salary
      t.integer :status
      t.integer :finished
      t.text :cover_letter
      t.text :comment

      t.timestamps
    end
  end
end
