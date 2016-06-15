class BillsController < ApplicationController
	before_action :set_bill, only: [:update_service]
	before_action :set_service, only: [:update_service]
  before_action :authorize_employee!, except: [:show]

  def index
  	@bills = Bill.persisted.paginate(:page => params[:page])
  end

  def show
  	@bill = Bill.find(params[:id])

    redirect_to root_path if @bill.employee.nil?
    
    unless current_user.admin? || current_user.employee?
      authorize_customer!(@bill.customer)
    end
  	@services = Service.all.order(:name)

    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "##{@bill.receipt.to_code}",
        encoding: "UTF-8",
          :template => 'bills/show.pdf.erb'
      end
    end

  end

  def search
    unless params[:search][:q].blank?
      @bills = Bill.search(params[:search][:q])
    else
      @bills = Bill.all
    end
    
    @bills = @bills.paginate(:page => params[:page])

    render :index
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
