class ServicesController < ApplicationController
  before_action :authorize_employee!

  # GET /services
  # GET /services.json
  def index
    @services = Service.all.order(:name)
  end
end
