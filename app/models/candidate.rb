class Candidate < ActiveRecord::Base
  attr_accessible :address, :agreement_letter, :born_date, :born_place, :email, :field_activity_description_1, :field_activity_description_2, :final_project, :final_task_plan, :from_program, :from_university, :full_name, :ijazah, :ipk, :number, :phone, :photo, :rank, :to_program, :toefl, :transkrip_nilai
end
