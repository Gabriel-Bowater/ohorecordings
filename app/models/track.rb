class Track < ActiveRecord::Base
  belongs_to :album
  has_many :track_orders
  has_many :track_rights

  def in_cart(user_id)
  	if user_id
  		if Order.where(user_id: user_id, completed: false)[0]
  			order = Order.where(user_id: user_id, completed: false)[0]
  			if TrackOrder.exists?(order_id: order.id, track_id: self.id)
  				return true
  			else
  				return false
  			end
  		end
  	else
  		return false
  	end
  end

    def in_library(user_id)
  	if user_id
  		if TrackRight.exists?(user_id: user_id, track_id: self.id)
  			return true
  		else
  			return false
  		end
  	end
  	false
  end


end
