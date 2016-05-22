class StatisticsController < ApplicationController
	def index
		@revenue = Statistic.new
	end
end
