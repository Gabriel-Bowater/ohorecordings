class OrdersController < ApplicationController
	protect_from_forgery except: [:hook]
	
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
				TrackOrder.create(order_id: @order.id, track_id: track.id, price: track.price)
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

		order = Order.find(params[:id])
		redirect_to paypal_url(params[:order_total], params[:id], order.user)
		# render text: params
	end

 def paypal_url(order_total, id, user)
    values = {
        business: "davebow@netaccess.co.nz",
        cmd: "_xclick",
        return: "#{Rails.configuration.app_host}users/#{@user.id}",
        invoice: "#{SecureRandom.hex(2)}#{id}",
        amount: order_total,
        item_name: "Oho Recordings order for #{ @user.given_name } #{ @user.family_name }. #{Time.now}",
        no_shipping: 1,
        currency_code: "NZD",
        rm: 0,
        notify_url: "#{Rails.configuration.app_host}/hook"
    }
    "https://www.paypal.com/cgi-bin/webscr?" + values.to_query
    # render text: values
  end

  def hook
    params.permit! # Permit all Paypal input params
    status = params[:payment_status]
    id = params[:invoice].slice(4..7).to_i
    order = Order.find(id)
    if status == "Completed"
    	AlbumOrder.where(order_id: order.id).each do |album|
				AlbumRight.create(user_id: order.user_id, album_id: album.album_id)
			end
			TrackOrder.where(order_id: order.id).each do |track|
				TrackRight.create(user_id: order.user_id, track_id: track.track_id)
			end
			order.update(completed: true,  completed_at: Time.now, amount_paid: params[:mc_gross],
									 status: status, transaction_id: params[:txn_id]) #Test if you get the price back TODO | amount_paid: params[:amount_paid], |
    end
    render nothing: true
  end

end