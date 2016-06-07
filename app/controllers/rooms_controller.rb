class RoomsController < ApplicationController
	before_action :set_room, only: [:show]
	before_action :authorize_employee!

	def index
		@rooms = Room.all.order(:name)
	end

	def show
	end


	private

	def set_room
		@room = Room.find(params[:id])
	end
end
