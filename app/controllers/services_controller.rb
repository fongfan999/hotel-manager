class ServicesController < ApplicationController
  before_action :authorize_employee!

  # GET /services
  # GET /services.json
  def index
    @services = Service.excluding_archived.order(:name).paginate(:page => params[:page])

    respond_to do |format|
      format.html
      format.json { render :json => Service.all }
    end
  end
end
