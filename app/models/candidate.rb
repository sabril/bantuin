class Candidate < ActiveRecord::Base
  attr_accessible :address, :agreement_letter, :born_date, :born_place, :email, :field_activity_description_1, :field_activity_description_2, :final_project, :final_task_plan, :from_program, :from_university, :full_name, :ijazah, :ipk, :number, :phone, :photo, :rank, :to_program, :toefl, :transkrip_nilai, :photo_cache, :ijazah_cache, :transkrip_nilai_cache, :final_project_cache, :agreement_letter_cache, :final_task_plan_cache, :sumbangan
  validates :photo, :presence => true,
      :file_size => { 
        :maximum => 0.5.megabytes.to_i
      }, :if => lambda {|o| o.current_step == "bio" || o.current_step == ""}
      
  validates :ijazah, :transkrip_nilai, :presence => true, :file_size => {
    :maximum => 1.megabytes.to_i
  }, :if => lambda {|o| o.current_step == "legals"}
  
  validates :agreement_letter, :final_project, :presence => true, :file_size => {
    :maximum => 1.megabytes.to_i
  }, :if => lambda {|o| o.current_step == "documents"}
  #validates_presence_of :address, :agreement_letter, :born_date, :born_place, :email, :field_activity_description_1, :final_project, :final_task_plan, :from_program, :from_university, :full_name, :ijazah, :ipk, :phone, :photo, :rank, :to_program, :transkrip_nilai
  validates_presence_of :full_name, :address, :born_place, :born_date, :email, :phone, :from_university, :from_program, :rank, :ipk, :to_program, :if => lambda {|o| o.current_step == "bio" || o.current_step == ""}
  validates_presence_of :ijazah, :transkrip_nilai, :if => lambda {|o| o.current_step == "legals"}
  #validates_presence_of :final_task_plan, :if => lambda {|o| o.current_step == "documents"}
  validates_numericality_of :ipk, :greater_than_or_equal_to => 0.0, :less_than_or_equal_to => 4.0
  

  
  mount_uploader :photo, PhotoUploader
  mount_uploader :ijazah, IjazahUploader
  mount_uploader :transkrip_nilai, TranskripNilaiUploader
  mount_uploader :field_activity_description_1, FieldActivityDescriptionOneUploader
  mount_uploader :field_activity_description_2, FieldActivityDescriptionTwoUploader
  mount_uploader :final_project, FinalProjectUploader
  mount_uploader :agreement_letter, AgreementLetterUploader
  mount_uploader :final_task_plan, FinalTaskPlanUploader
  
  before_create :check_number
  
  validate :check_ipk
  validate :check_sumbangan
  
  attr_writer :current_step
  
  
  def check_ipk
    if self.to_program == "IF" && ipk < 3
      errors.add(:ipk, " untuk program studi Teknik Informatika harus >= 3.00")
    end
  end
  
  def check_sumbangan
    if (self.to_program == "IF" || self.to_program == "TT") && sumbangan < 6000000
      errors.add(:sumbangan, " untuk program studi Teknik Informatika dan Teknik Telekomunikasi minimal sumbangan Rp.6.000.000,-")
    elsif self.to_program == "SK"  && sumbangan < 4000000
      errors.add(:sumbangan, " untuk program studi Sistem Komputer minimal sumbangan Rp.4.000.000,-")
    end
  end
  
  def on_bio?
    self.status == "legals" || self.status == "bio"
  end
  
  def on_legals?
    self.status == "legals" || self.status == "documents"
  end
  
  def on_documents?
    self.status == "finish" || self.status == "documents"
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
      self.number = max_number.to_i + 1
    end
  end
  
  
  def steps
    %w{bio legals documents finish}
  end
  
  def current_step
    @current_step || steps.first
  end
  
  def next_step
    self.current_step = steps[steps.index(current_step) + 1]
  end
  
  def previous_step
    self.current_step = steps[steps.index(current_step) - 1]
  end
  
  def first_step?
    current_step == steps.first
  end
  
  def last_step?
    current_step == steps.last
  end
end
