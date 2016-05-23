class StatisticsController < ApplicationController
	def index
		@date = Statistic.first || Statistic.create

		begin_day = Date.today
		end_day = Date.today
		@date.update(start_date: begin_day, end_date: end_day)
	end

	def search
		@date = Statistic.first
		@date.update(date_params)

		begin_day = @date.start_date.beginning_of_day
		end_day = @date.end_date.end_of_day
		@date.update(start_date: begin_day, end_date: end_day)

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
