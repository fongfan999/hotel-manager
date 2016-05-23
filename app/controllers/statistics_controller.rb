class StatisticsController < ApplicationController
	def index
		@date = Statistic.first || Statistic.create(start_date: DateTime.now.to_date,
				end_date: DateTime.now.to_date)

		@room = Room.find(5)
	end

	def search
		
		@date = Statistic.first
		@date.update(date_params)

		if @date.start_date <= @date.end_date
			flash[:notice] = "Successful" 
			# @bill = Bill.first
		else
			flash[:alert] = "There"
		end

		render "statistics/index"
		# redirect_to statistics_path
	end

	private

	def date_params
		params.require(:statistic).permit(:start_date, :end_date)
	end
end
