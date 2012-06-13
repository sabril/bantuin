class App < ActiveRecord::Base
  belongs_to :job
  belongs_to :user
  ajaxful_rateable :stars => 5, :dimensions => [:rating],:allow_update => true
end
