class Album < ActiveRecord::Base
  has_many :tracks
  has_many :album_rights
  has_many :album_orders
  before_save :nil_if_blank

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

  protected

  def nil_if_blank
    null_attrs = ["art_url", "artists", "flac_arch_url", "mp3_arch_url", "aac_arch_url", "ogg_arch_url",
                  "alac_arch_url", "description", "isrc", "year"]
    null_attrs.each { |attr| self[attr] = nil if self[attr].blank? }
  end

end
