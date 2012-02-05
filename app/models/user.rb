class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable, :encryptable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :roles_mask, :roles, :avatar, :completeness, :address_attributes, :time_zone
  mount_uploader :avatar, AvatarUploader
  before_save :recalculate_completeness
  has_one :address, :as => :addressable
  
  accepts_nested_attributes_for :address, :allow_destroy => true
  
  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject do |r|
      ((roles_mask || 0) & 2**ROLES.index(r)).zero?
    end
  end
  
  def is?(role)
    roles.include?(role.to_s)
  end
  
  def recalculate_completeness
    self.completeness = 0
    self.completeness += 10 if self.avatar?
    self.completeness += 10 if self.address.line_1
    self.completeness += 10 if self.address.country
  end
end
