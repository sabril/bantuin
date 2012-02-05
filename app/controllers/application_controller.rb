class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_current_timezone
  def set_current_timezone
    Time.zone = current_user.time_zone if user_signed_in?
  end
end
