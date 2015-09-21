class AlbumOrdersController < ApplicationController

	def destroy
		AlbumOrder.find(params[:id]).destroy
		redirect_to orders_path
	end


end
