class Job < ActiveRecord::Base
  attr_accessible :user_id, :title, :description, :area, :salary, :keyword,
  :time_start,:status
  
  has_many :apps
  belongs_to :user
  ajaxful_rateable :stars => 5, :dimensions => [:rating],:allow_update => true
end
