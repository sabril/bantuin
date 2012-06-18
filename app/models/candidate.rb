class Candidate < ActiveRecord::Base
  attr_accessible :address, :agreement_letter, :born_date, :born_place, :email, :field_activity_description_1, :field_activity_description_2, :final_project, :final_task_plan, :from_program, :from_university, :full_name, :ijazah, :ipk, :number, :phone, :photo, :rank, :to_program, :toefl, :transkrip_nilai
  #validates_presence_of :address, :agreement_letter, :born_date, :born_place, :email, :field_activity_description_1, :final_project, :final_task_plan, :from_program, :from_university, :full_name, :ijazah, :ipk, :phone, :photo, :rank, :to_program, :transkrip_nilai
  
  mount_uploader :photo, PhotoUploader
  mount_uploader :ijazah, IjazahUploader
  mount_uploader :transkrip_nilai, TranskripNilaiUploader
  mount_uploader :field_activity_description_1, FieldActivityDescriptionOneUploader
  mount_uploader :field_activity_description_2, FieldActivityDescriptionTwoUploader
  mount_uploader :final_project, FinalProjectUploader
  mount_uploader :agreement_letter, AgreementLetterUploader
  
  before_save :check_number
  
  validate :check_ipk
  
  def check_ipk
    if self.to_program == "IF" && ipk < 3
      errors.add(:ipk, " untuk program studi Teknik Informatika harus >= 3.00")
    end
  end
  
  def check_number
    if self.to_program == "TT"
      n = "12111"
    elsif self.to_program == "IF"
      n = "12113"
    elsif self.to_program == "SK"
      n = "12114"
    end
    
    max_number = Candidate.where{number.like "#{n}%" }.map(&:number).max #number like ? ", "#{number}%").map(&:number)
    if max_number.nil?
      self.number = n + "001"
    else
      self.number = max_number + 1
    end
    
    #self.number = Candidate.all.map(&:number).max.to_i + 1
  end
end
