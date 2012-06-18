class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.string :number
      t.string :full_name
      t.string :born_place
      t.date :born_date
      t.text :address
      t.string :email
      t.string :phone
      t.string :from_university
      t.string :from_program
      t.string :rank
      t.string :toefl
      t.float :ipk
      t.string :to_program
      t.string :photo
      t.string :ijazah
      t.string :transkrip_nilai
      t.string :field_activity_description_1
      t.string :field_activity_description_2
      t.string :final_project
      t.text :final_task_plan
      t.string :agreement_letter
      t.timestamps
    end
  end
end
