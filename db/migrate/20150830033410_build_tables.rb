class BuildTables < ActiveRecord::Migration
  def change
    create_table :users do |t|
      # t.has_many :orders
      # t.has_many :track_rights
      # t.has_many :album_rights

      t.string :email, null: false, uniqueness: true
      t.string :given_name
      t.string :family_name
      t.string :address_one
      t.string :address_two
      t.string :address_city
      t.string :address_country
      t.string :password_hash
      t.boolean :email_confirmed, null: false, default: true

      t.timestamps null: false
    end

    create_table :albums do |t|
      # t.has_many :tracks
      # t.has_many :album_orders
      # t.has_many :album_rights

      t.string :name, null: false, uniqueness: true
      t.string :art_url
      t.string :artists
      t.string :flac_arch_url
      t.string :mp3_arch_url
      t.string :aac_arch_url
      t.string :ogg_arch_url
      t.string :alac_arch_url
      t.text :description
      t.decimal :price, default: 10.00, null: false
      t.string :isrc
      t.string :year

      t.timestamps null: false
    end

    create_table :tracks do |t|
      t.belongs_to :album
      # t.has_many :track_orders
      # t.has_many :track_rights

      t.integer :album_id
      t.string :name, null: false, uniqueness: true
      t.integer :track_number
      t.string :flac_url
      t.string :mp3_url
      t.string :aac_url
      t.string :ogg_url
      t.string :alac_url
      t.string :sample_url
      t.decimal :price, default: 2.00, null: false
      t.string :track_isrc

      t.timestamps null: false
    end

    create_table :track_rights do |t|
      t.belongs_to :user
      t.belongs_to :track

      t.timestamps null: false
    end

    create_table :album_rights do |t|
      t.belongs_to :user
      t.belongs_to :album

      t.timestamps null: false
    end

    create_table :orders do |t|
      t.belongs_to :user

      t.boolean :completed, default: false, null: false
    end

    create_table :album_orders do |t|
      t.belongs_to :order
      t.belongs_to :album

      t.timestamps null: false
    end

    create_table :track_orders do |t|
      t.belongs_to :order
      t.belongs_to :track

      t.timestamps null: false
    end

  end

end
