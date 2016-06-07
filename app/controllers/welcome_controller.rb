class WelcomeController < ApplicationController
	skip_before_action :authenticate_user!
	before_action :activate_account!
	
  def index
  end
end
