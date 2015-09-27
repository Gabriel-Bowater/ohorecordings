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
	art_url = ["https://upload.wikimedia.org/wikipedia/en/4/46/Run_Kid_Run_-_Love_At_The_Core_(Album_Art).jpg",
				"http://www.smashingmagazine.com/images/music-cd-covers/43.jpg",
				"http://illusion.scene360.com/wp-content/uploads/2013/10/album-covers-05.jpg",
				"http://www.smashingmagazine.com/images/100-obscure-remarkable-cd-covers/greenday.jpg"].sample
	artist = Faker::Name.name
	description = Faker::Lorem.paragraph
	price = Faker::Commerce.price.to_f
	year = rand(1980..2010)

	current_album = Album.create(name: name,
								art_url: art_url,
								artists: artist,
								description: description,
								price: price,
								year: year)

	8.times do |i|
		track_name = Faker::Company.name
		track_number = i+1
		sample_url = ["http://www.wavsource.com/snds_2015-09-20_4380281261564803/movie_stars/murphy/listen_up.wav", 
						"http://www.wavsource.com/snds_2015-09-20_4380281261564803/movie_stars/murphy/worst_nightmare.wav",
						"http://www.wavsource.com/snds_2015-09-20_4380281261564803/movie_stars/murphy/murphy_laugh.wav",
						"http://www.wavsource.com/snds_2015-09-20_4380281261564803/movie_stars/murphy/be_cool.wav",
						"http://www.wavsource.com/snds_2015-09-20_4380281261564803/movie_stars/murphy/48_hrs_class.wav",
						"http://www.wavsource.com/snds_2015-09-20_4380281261564803/movie_stars/murphy/how_ya_doin_x.wav"].sample
		Track.create(album_id: current_album.id,
					name: track_name,
					track_number: track_number,
					price: 2.00,
					sample_url: sample_url)
	end


end

