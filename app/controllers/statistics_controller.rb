class StatisticsController < ApplicationController
	before_action :authorize_admin!
	
	def index
		@date = Statistic.first || Statistic.create

		begin_day = Date.today
		end_day = Date.today
		@date.update(start_date: begin_day, end_date: end_day)

		respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "Statistics",
          :template => 'statistics/index.pdf.erb'
      end
    end
	end

	def search
		@date = Statistic.first
		@date.update(date_params)

		unless @date.start_date <= @date.end_date
			flash.now[:alert] = "There was a problem with date"
			begin_day = Date.today
			end_day = Date.today
			@date.update(start_date: begin_day, end_date: end_day)
		end

		render "statistics/index"
	end

	private

	def date_params
		params.require(:statistic).permit(:start_date, :end_date)
	end
end
