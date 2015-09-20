class OrdersController < ApplicationController
	def new
		render text: params
	end

	def create
		if !session[:user_id]
			flash.alert = "Please log in if you'd like to place an order"
			redirect_to new_user_path
		end
	end
end