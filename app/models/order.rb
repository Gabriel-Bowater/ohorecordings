class Order < ActiveRecord::Base
  belongs_to :user
  has_many :album_orders
  has_many :track_orders

  def self.collect_trash
		orders = Order.where('updated_at < :three_days_ago', :three_days_ago => Time.now - 3.days)
		orders.each do |order|
			if !order.completed
				AlbumOrder.where(order_id: order.id).each do |album_order|
					album_order.destroy
					p "Album Order " + album_order.id.to_s + " destroyed in cleanup"
				end
				TrackOrder.where(order_id: order.id).each do |track_order|
					track_order.destroy
					p "Track Order" + track_order.id.to_s + " destroyed in cleanup"
				end
				order.destroy
				p "Order " + order.id.to_s + " destroyed in cleanup."
			end
		end
	end
end
