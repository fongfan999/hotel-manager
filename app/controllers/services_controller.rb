class ServicesController < ApplicationController
  before_action :authorize_employee!

  # GET /services
  # GET /services.json
  def index
    @services = Service.all.order(:name)

    respond_to do |format|
      format.html
      format.json { render :json => Service.all }
    end
  end
end
