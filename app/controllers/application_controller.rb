class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :authenticate_user!
  before_action :set_current_user
  protect_from_forgery with: :exception
  
  private

  def authorize_admin!
  	unless current_user.try(:admin?)
      flash.now[:alert] = "You must be an admin to do that."
  		redirect_to root_path
  	end
  end

  def authorize_customer!(customer)
    unless current_user.customer == customer
      flash.now[:alert] = "You aren't allowed to do that."
      redirect_to root_path
    end
  end

  def set_current_user
    User.current_user = current_user
  end
end
