class TrackOrdersController < ApplicationController

	def destroy
		TrackOrder.find(params[:id]).destroy
		redirect_to orders_path
	end


end
