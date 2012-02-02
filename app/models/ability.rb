class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user ||= User.new
    @user.roles.each { |role| send(role) }
  end
  
  def provider
  end
  
  def employer
  end
end
