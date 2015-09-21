class Album < ActiveRecord::Base
  has_many :tracks
  has_many :album_rights
  has_many :album_orders

   def in_cart(user_id)
  	if user_id
  		if Order.where(user_id: user_id, completed: false)[0]
  			order = Order.where(user_id: user_id, completed: false)[0]
  			if AlbumOrder.exists?(order_id: order.id, album_id: self.id)
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
  		if AlbumRight.exists?(user_id: user_id, album_id: self.id)
  			return true
  		else
  			return false
  		end
  	end
  	false
  end
end
