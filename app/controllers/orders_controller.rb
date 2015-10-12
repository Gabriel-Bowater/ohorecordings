class OrdersController < ApplicationController
	def new
		render text: params
	end

	def create
		if !session[:user_id]
			flash.notice = "Please log in if you'd like to place an order"
			redirect_to new_user_path
		
		else
			if Order.exists?(user_id: session[:user_id], completed: false)
				@order = Order.where(user_id: session[:user_id], completed: false)[0]
			else 
				@order = Order.create(user_id: session[:user_id])
			end
			
			if params[:album_id]
				album = Album.find(params[:album_id])
				AlbumOrder.create(order_id: @order.id, album_id: album.id, price: album.price)
			end

			if params[:track_id]
				track = Track.find(params[:track_id])
				TrackOrder.create(order_id: @order.id, track_id: track.id, price: album.price)
			end

			redirect_to orders_path
		end

	end

	def index
		order = Order.where(user_id: session[:user_id], completed: false)[0]
		@order_total = 0.0
		if order
			@user_album_orders = AlbumOrder.where(order_id: order.id)
			@user_track_orders = TrackOrder.where(order_id: order.id)
			@user_album_orders.each { |album| @order_total += Album.find(album.album_id).price} 
			@user_track_orders.each { |track| @order_total += Track.find(track.track_id).price} 
		end
		@order = order
	end

	def update
		paid = true
		order = Order.find(params[:id])
		if paid
			AlbumOrder.where(order_id: order.id).each do |album|
				AlbumRight.create(user_id: order.user_id, album_id: album.album_id)
			end
			TrackOrder.where(order_id: order.id).each do |track|
				TrackRight.create(user_id: order.user_id, track_id: track.track_id)
			end
		end
		order.update(completed: true)
		redirect_to user_path
	end

	private

	 def paypal_url(return_path)
    values = {
        business: "merchant@gotealeaf.com",
        cmd: "_xclick",
        upload: 1,
        return: "#{Rails.application.secrets.app_host}#{return_path}",
        invoice: id,
        amount: course.price,
        item_name: course.name,
        item_number: course.id,
        quantity: '1'
    }
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end

end