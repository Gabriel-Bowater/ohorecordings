S3DirectUpload.config do |c|
	c.bucket = 'ohorecordings'
	c.region = 's3-ap-southeast-2'
	c.url = "https://ohorecordings.s3-ap-southeast-2.amazonaws.com/" 
	if(Rails.env == 'development')
	  c.access_key_id = Rails.application.secrets.aws_access_key_id
  	c.secret_access_key = Rails.application.secrets.aws_secret_key
	elsif(Rails.env == 'production')
		c.access_key_id = ENV['AWS_ACCESS_KEY_ID']
		c.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
	end
end
