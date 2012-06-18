class Candidate < ActiveRecord::Base
  attr_accessible :address, :agreement_letter, :born_date, :born_place, :email, :field_activity_description_1, :field_activity_description_2, :final_project, :final_task_plan, :from_program, :from_university, :full_name, :ijazah, :ipk, :number, :phone, :photo, :rank, :to_program, :toefl, :transkrip_nilai
  validates_presence_of :address, :agreement_letter, :born_date, :born_place, :email, :field_activity_description_1, :final_project, :final_task_plan, :from_program, :from_university, :full_name, :ijazah, :ipk, :phone, :photo, :rank, :to_program, :transkrip_nilai
  
  mount_uploader :photo, PhotoUploader
  mount_uploader :ijazah, IjazahUploader
  mount_uploader :transkrip_nilai, TranskripNilaiUploader
  mount_uploader :field_activity_description_1, FieldActivityDescriptionOneUploader
  mount_uploader :field_activity_description_2, FieldActivityDescriptionTwoUploader
  mount_uploader :final_project, FinalProjectUploader
  mount_uploader :agreement_letter, AgreementLetterUploader
  
  before_save :check_number
  
  def check_number
    if self.to_program == "TT"
      number = "12111"
    elsif self.to_program == "IF"
      number = "12113"
    elsif self.to_program == "SK"
      number = "12114"
    end
    
    #students = Candidate.where("number like ? ", "#{number}%").map(&:number)
    self.number = Candidate.all.map(&:number).max + 1
  end
end
