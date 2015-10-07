class Album < ActiveRecord::Base
  has_many :tracks
  has_many :album_rights
  has_many :album_orders
  before_save :nil_if_blank
  has_attached_file :mp3, :storage => :s3
  validates_attachment_file_name :mp3, :matches => [/rar\Z/, /zip\Z/]
  has_attached_file :alac, :storage => :s3
  validates_attachment_file_name :alac, :matches => [/rar\Z/, /zip\Z/]
  has_attached_file :aac, :storage => :s3
  validates_attachment_file_name :aac, :matches => [/rar\Z/, /zip\Z/]
  has_attached_file :ogg, :storage => :s3
  validates_attachment_file_name :ogg, :matches => [/rar\Z/, /zip\Z/]
  has_attached_file :flac, :storage => :s3
  validates_attachment_file_name :flac, :matches => [/rar\Z/, /zip\Z/]


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
    null_attrs = ["art_url", "artists", "description", "isrc", "year"]
    null_attrs.each { |attr| self[attr] = nil if self[attr].blank? }
  end

end
