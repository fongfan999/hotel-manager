class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  before_action :authorize_admin!, except: [:show]

  def index
    @customers = Customer.all.order(:name)
  end

  def show
    authorize_customer!(@customer) unless current_user.admin?
    @receipts = Receipt.where(customer: @customer)
      .paginate(:page => params[:page], per_page: 10)
    @bills = Bill.available_bill.paginate(:page => params[:page], per_page: 10)
  end

  def new
    @customer = Customer.new
  end

  def edit
  end

  def create
    @customer = Customer.new(room_params)

    if @customer.save
      password = @customer.identity_card
      email = @customer.name.split[-1].downcase + "#{password}@example.com"
      account = User.create!(email: email, password: password)
      @customer.account = account
      @customer.save

      flash[:notice] = "Customer was successfully created."
      redirect_to @customer
    else
      flash[:alert] = "Customer was not successfully created."
      render :new
    end
  end

  def update
    if @customer.update(room_params)
      flash[:notice] = "Customer was successfully updated."
      redirect_to @customer
    else
      flash[:alert] = "Customer was not successfully updated."
      render :edit
    end
  end

  def destroy
    @customer.destroy
    flash.now[:notice] = "Customer was successfully destroyed."
    redirect_to rooms_path
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def room_params
    params.require(:customer).permit(:name, :type_id, :identity_card,
      :phone_number, :address)
  end
end

