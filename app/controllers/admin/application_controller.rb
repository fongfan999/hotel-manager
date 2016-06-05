class Admin::ApplicationController < ApplicationController
	before_action :authorize_admin!

  def index
  end

  private

  def authorize_admin!
  	unless current_user.try(:admin?)
      flash.now[:alert] = "You must be an admin to do that."
  		redirect_to root_path
  	end
  end
end
