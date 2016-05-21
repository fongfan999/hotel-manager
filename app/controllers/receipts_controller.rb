class ReceiptsController < ApplicationController
	before_action :set_receipt, only: [:show, :edit, :update, :pay]

	def index
		@receipts = Receipt.all
	end

	def show
	end

	def pay
		@bill = @receipt.bill
		@bill.employee = current_user
		@bill.update(created_at: Time.now)
		@bill.save
		redirect_to @bill
	end

	def new
		@receipt = Receipt.new
	end

	def edit
		unless @receipt.bill.employee.nil?
			flash[:alert] = "You aren't allowed to do that."
			redirect_to receipts_path
		end
	end

	def create
		@receipt = Receipt.new(receipt_params)
		@receipt.employee = current_user
		if @receipt.save
			Bill.create(receipt_id: @receipt.id)
			flash[:notice] = "Receipt was successfully created."
			redirect_to @receipt
		else
			flash[:alert] = "Receipt was not successfully created."
			render :new
		end
	end

	def update
		if @receipt.update(receipt_params)
			flash[:notice] = "Receipt was successfully updated."
			redirect_to receipts_path
		else
			flash[:alert] = "Receipt was not successfully updated."
			render :edit
		end
	end

	private

	def set_receipt
		@receipt = Receipt.find(params[:id])
	end

	def receipt_params
		params.require(:receipt).permit(:customer_id, :room_id, :quantity)
	end
end
