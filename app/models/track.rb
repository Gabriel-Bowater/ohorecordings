class Track < ActiveRecord::Base
  belongs_to :album
  has_many :track_orders
  has_many :track_rights
  before_save :nil_if_blank


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

  protected

  def nil_if_blank
    null_attrs = ["flac_url", "mp3_url", "aac_url", "ogg_url", "alac_url", "sample_url", "track_isrc"]
    null_attrs.each { |attr| self[attr] = nil if self[attr].blank? }
  end

end
