# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

10.times do 
	user = Faker::Name.name
	email = user.split.join('.') + '@gmail.com'
	given_name = user.split[0]
	family_name = user.split[1]
	address_one = Faker::Address.street_address
	address_city = Faker::Address.city
	address_country = Faker::Address.country
	password = Faker::Internet.password

	User.create(email: email, 
				given_name: given_name, 
				family_name: family_name,
				address_one: address_one,
				address_city: address_city,
				address_country: address_country,
				password_hash: password)

	name = Faker::Company.name
	art_url = Faker::Avatar.image
	artist = Faker::Name.name
	description = Faker::Lorem.paragraph
	price = Faker::Commerce.price.to_f

	current_album = Album.create(name: name,
								art_url: art_url,
								artists: artist,
								description: description,
								price: price)

	8.times do |i|
		track_name = Faker::Company.name
		track_number = i+1

		Track.create(album_id: current_album.id,
					name: track_name,
					track_number: track_number)
	end


end

