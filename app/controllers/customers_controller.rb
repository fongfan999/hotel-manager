require 'will_paginate/array'
class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  before_action :authorize_admin!, except: [:show]

  def index
    @customers = Customer.all.order(:name).paginate(:page => params[:page])
  end

  def show
    authorize_customer!(@customer) unless current_user.admin?
    @receipts = Receipt.where(customer: @customer)
      .paginate(:page => params[:page])
    @bills = Bill.available_bill.paginate(:page => params[:page])
  end

  def new
    @customer = Customer.new
  end

  def edit
  end

  def search
    unless params[:search][:q].blank?
      @customers = Customer.search(params[:search][:q])
    else
      @customers = Customer.all
    end
    
    @customers = @customers.paginate(:page => params[:page])

    render :index
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

