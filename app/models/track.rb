class Track < ActiveRecord::Base
  belongs_to :album
  has_many :track_orders
  has_many :track_rights
  before_save :nil_if_blank
  has_attached_file :mp3, :storage => :s3
  validates_attachment_file_name :mp3, :matches => [/mp3\Z/]
  has_attached_file :alac, :storage => :s3
  validates_attachment_file_name :alac, :matches => [/m4a\Z/]
  has_attached_file :aac, :storage => :s3
  validates_attachment_file_name :aac, :matches => [/aac\Z/]
  has_attached_file :ogg, :storage => :s3
  validates_attachment_file_name :ogg, :matches => [/ogg\Z/]
  has_attached_file :flac, :storage => :s3
  validates_attachment_file_name :flac, :matches => [/flac\Z/]


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
    null_attrs = ["sample_url", "track_isrc"]
    null_attrs.each { |attr| self[attr] = nil if self[attr].blank? }
  end

end
