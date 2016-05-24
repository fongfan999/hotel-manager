class RoomsController < ApplicationController
	before_action :set_room, only: [:show, :edit, :update, :destroy]
	skip_before_action :authenticate_user!, only: [:index]
	before_action :authorize_admin!, except: [:index]

	def index
		@rooms = Room.all.order(:name)
	end

	def show
	end

	def new
		@room = Room.new
	end

	def edit
	end

	def create
		@room = Room.new(room_params)

		if @room.save
			flash[:notice] = "Room was successfully created."
			redirect_to @room
		else
			flash[:alert] = "Room was not successfully created."
			render :new
		end
	end

	def update
		if @room.update(room_params)
			flash[:notice] = "Room was successfully updated."
			redirect_to @room
		else
			flash[:alert] = "Room was not successfully updated."
			render :edit
		end
	end

	def destroy
		if @room.customers.blank?
			flash[:alert] = "You aren't allowed to do that."
			redirect_to rooms_path
		end
		@room.destroy
		flash.now[:notice] = "Room was successfully destroyed."
		redirect_to rooms_path
	end

	private

	def set_room
		@room = Room.find(params[:id])
	end

	def room_params
		params.require(:room).permit(:name, :type_id, :annotation)
	end
end
