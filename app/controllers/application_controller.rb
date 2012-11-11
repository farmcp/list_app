class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  private

  def admin_only
    redirect_to root_path unless current_user.admin?
  end
end
