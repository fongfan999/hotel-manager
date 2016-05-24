class BillsController < ApplicationController
	before_action :set_bill, only: [:update_service]
	before_action :set_service, only: [:update_service]
  before_action :authorize_admin!, except: [:show]

  def index
  	@bills = Bill.all.paginate(:page => params[:page], per_page: 10)
  end

  def show
  	@bill = Bill.find(params[:id])
    status = authorize_customer!(@bill.customer) unless current_user.admin?
  	@services = Service.all.order(:name)
    
    unless status
      respond_to do |format|
        format.html
        format.pdf do
          render :pdf => "##{@bill.receipt.code}",
            :template => 'bills/show.pdf.erb'
        end
      end
    end
  end

  def report
  end

  def update_service
  	if quantity <= -1
  		flash[:alert] = "There was a problem with Quantity"
		else
			bill_services = BillService.find_by(service_id: @service.id,
	  		bill_id: @bill.id)
			if bill_services
				bill_services.update(quantity: quantity)
			else
				BillService.create(quantity: quantity, service_id: @service.id,
					bill_id: @bill.id)
			end
			flash[:notice] = "Bill has been updated"
  	end
  	redirect_to @bill
  end

 	private

 	def set_bill
  	@bill = Bill.find(params[:bill_id])
  end

  def set_service
  	@service = Service.find(params[:id])
  end

  def quantity
  	params.require(:service)[:quantity].to_i 
  end
end
