require 'will_paginate/array'

class RoomsController < ApplicationController
	before_action :set_room, only: [:show]
	before_action :authorize_employee!

	def index
		@rooms = Room.excluding_archived.order(:name).paginate(:page => params[:page])
	end

	def show
	end

	def search
		unless params[:search][:q].blank?
			@rooms = Room.search(params[:search][:q])
		else
			@rooms = Room.all
		end
		
		@rooms = @rooms.paginate(:page => params[:page])

		render :index
	end


	private

	def set_room
		@room = Room.find(params[:id])
	end
end
