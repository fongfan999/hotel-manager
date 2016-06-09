class Admin::RoomTypesController < ApplicationController
	def index
		@types = RoomType.all
	end
	def edit
		@type = RoomType.find(params[:id])
	end

	def update
		@type = RoomType.find(params[:id])

		if @type.update(type_params)
			flash[:notice] = "RoomType has been updated."
			redirect_to admin_room_types_path
		else
			flash.now[:alert] = "RoomType has NOT been updated."
			render :edit
		end
	end

	private

	def type_params
		params.require(:room_type).permit(:name, :cost)
	end
end
