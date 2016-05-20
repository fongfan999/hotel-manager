class ReceiptsController < ApplicationController
	before_action :set_receipt, only: [:show, :edit, :update]

	def index
		@receipts = Receipt.all
	end

	def show
	end

	def new
		@receipt = Receipt.new
	end

	def edit
	end

	def create
		Receipt.create(receipt_params)
		flash[:notice] = "Receipt was successfully created."
		redirect_to receipts_path
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
