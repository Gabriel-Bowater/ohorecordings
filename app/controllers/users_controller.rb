class UsersController < ApplicationController

  def new
    @countries = countries
    # render text: @countries
  end

  def show

    if !@user
      redirect_to "/"
    else
      if params[:mp3_album_id]
        album = Album.find(params[:mp3_album_id])
        link = album.mp3.s3_object.url_for(:read, :secure => true, :expires => 20.minutes.from_now)
        flash.now[:alert] = "Your link: <a href=#{link}>Click here.</a> Your link will be valid for the next 20 minutes. Thank you for using Oho Recordings".html_safe
      elsif params[:ogg_album_id]
        album = Album.find(params[:ogg_album_id])
        link = album.ogg.s3_object.url_for(:read, :secure => true, :expires => 20.minutes.from_now)
        flash.now[:alert] = "Your link: <a href=#{link}>Click here.</a> Your link will be valid for the next 20 minutes. Thank you for using Oho Recordings".html_safe
      elsif params[:aac_album_id]
        album = Album.find(params[:aac_album_id])
        link = album.aac.s3_object.url_for(:read, :secure => true, :expires => 20.minutes.from_now)
        flash.now[:alert] = "Your link: <a href=#{link}>Click here.</a> Your link will be valid for the next 20 minutes. Thank you for using Oho Recordings".html_safe
      elsif params[:alac_album_id]
        album = Album.find(params[:alac_album_id])
        link = album.alac.s3_object.url_for(:read, :secure => true, :expires => 20.minutes.from_now)
        flash.now[:alert] = "Your link: <a href=#{link}>Click here.</a> Your link will be valid for the next 20 minutes. Thank you for using Oho Recordings".html_safe
      elsif params[:flac_album_id]
        album = Album.find(params[:flac_album_id])
        link = album.flac.s3_object.url_for(:read, :secure => true, :expires => 20.minutes.from_now)
        flash.now[:alert] = "Your link: <a href=#{link}>Click here.</a> Your link will be valid for the next 20 minutes. Thank you for using Oho Recordings".html_safe
      elsif params[:wav_album_id]
        album = Album.find(params[:wav_album_id])
        link = album.wav.s3_object.url_for(:read, :secure => true, :expires => 20.minutes.from_now)
        flash.now[:alert] = "Your link: <a href=#{link}>Click here.</a> Your link will be valid for the next 20 minutes. Thank you for using Oho Recordings".html_safe
      end
      
      if params[:mp3_track_id]
        track = Track.find(params[:mp3_track_id])
        link = track.mp3.s3_object.url_for(:read, :secure => true, :expires => 20.minutes.from_now)
        flash.now[:alert] = "Your link: <a href=#{link}>Click here.</a> Right click and choose 'Save As' to download. Your link will be valid for the next 20 minutes. Thank you for using Oho Recordings".html_safe
      elsif params[:ogg_track_id]
        track = Track.find(params[:ogg_track_id])
        link = track.ogg.s3_object.url_for(:read, :secure => true, :expires => 20.minutes.from_now)
        flash.now[:alert] = "Your link: <a href=#{link}>Click here.</a> Right click and choose 'Save As' to download. Your link will be valid for the next 20 minutes. Thank you for using Oho Recordings".html_safe
      elsif params[:aac_track_id]
        track = Track.find(params[:aac_track_id])
        link = track.aac.s3_object.url_for(:read, :secure => true, :expires => 20.minutes.from_now)
        flash.now[:alert] = "Your link: <a href=#{link}>Click here.</a> Right click and choose 'Save As' to download. Your link will be valid for the next 20 minutes. Thank you for using Oho Recordings".html_safe
      elsif params[:alac_track_id]
        track = Track.find(params[:alac_track_id])
        link = track.alac.s3_object.url_for(:read, :secure => true, :expires => 20.minutes.from_now)
        flash.now[:alert] = "Your link: <a href=#{link}>Click here.</a> Right click and choose 'Save As' to download. Your link will be valid for the next 20 minutes. Thank you for using Oho Recordings".html_safe
      elsif params[:flac_track_id]
        track = Track.find(params[:flac_track_id])
        link = track.flac.s3_object.url_for(:read, :secure => true, :expires => 20.minutes.from_now)
        flash.now[:alert] = "Your link: <a href=#{link}>Click here.</a> Right click and choose 'Save As' to download. Your link will be valid for the next 20 minutes. Thank you for using Oho Recordings".html_safe   
      elsif params[:wav_track_id]
        track = Track.find(params[:wav_track_id])
        link = track.wav.s3_object.url_for(:read, :secure => true, :expires => 20.minutes.from_now)
        flash.now[:alert] = "Your link: <a href=#{link}>Click here.</a> Right click and choose 'Save As' to download. Your link will be valid for the next 20 minutes. Thank you for using Oho Recordings".html_safe               
      end

      # @user = User.find(session[:user_id]) #User.find(session[:user_id])
      @user_albums = []
      @user_tracks = []
      AlbumRight.where(user_id: @user.id).each do |right|
        @user_albums << Album.find(right.album_id)
      end
      TrackRight.where(user_id: @user.id).each do |right|
        @user_tracks << Track.find(right.track_id)
      end
    end
  end

  def create
    if  verify_recaptcha && User.where(email: params[:email]).length == 0#Comment out for ngrok testing verify_recaptcha &&
      @user = User.new(email: params[:email].downcase,
                        given_name: params[:given_name],
                        family_name: params[:family_name],
                        address_one: params[:address_one],
                        address_two: params[:address_two],
                        address_city: params[:address_city],
                        address_country: params[:address_country],
                        email_confirmed: false)
      @user.password = params[:password]
      @user.save!
      AppMailer.welcome_email(@user).deliver_now
      flash[:alert] = "User profile created. Please check your email inbox for an email confirmation message."
      redirect_to '/'
    elsif User.where(email: params[:email]).length > 0
      flash[:alert] = "User profile with email #{params[:email]} already exists. Please log in."
      redirect_to new_user_path
    else #Comment out for ngrok testing
      flash[:alert] = "Existential crisis detected. Pleace click the reCaptcha tick box to establish your reality."
      redirect_to new_user_path
    end #Comment out for ngrok testing
  end

  def confirm
    @user = User.find(params[:id])
    if @user.confirm_code == params[:code]
      @user.email_confirmed = true
      @user.update(confirm_code: SecureRandom.hex)
      flash[:alert] = "Email #{@user.email} confirmed. Thank you. You are now logged in."
      session[:user_id] = @user.id
    else
      flash[:alert] = "Invalid email confirmation code."
    end
    redirect_to "/"
  end

  def recover
  end

  def reset
    if verify_recaptcha && User.find_by(email: params[:email])
      AppMailer.recovery_email(User.find_by(email: params[:email])).deliver_now
      flash[:alert] = "Email sent. Check your inbox."
    elsif !(verify_recaptcha)
      flash[:alert] = "Please click the box in the reCaptcha"
    else
      flash[:alert] = "Email address not found."
    end
    redirect_to "/"
  end

  def change_password
    @user = User.find(params[:id])
    if !(@user.confirm_code == params[:code])
      redirect_to '/'
    end
  end

  def new_password
    
    user = User.find(params[:user_id])
    if params[:password] == params[:password_confirm]
      flash[:alert] = "Password reset. Please log in."
      user.password = params[:password]
      user.update(confirm_code: SecureRandom.hex)
      redirect_to "/"
    else
      flash[:alert] = "Please make sure your passwords match."
      redirect_to(:back)
    end      
  end

  private

  def countries
    arr = ["New Zealand", "Australia", "United Kingdom",
          "United States of America", "Ireland", "Canada",
          "Afghanistan", "Albania", "Algeria", 
          "American Samoa", "Andorra", "Angola", 
          "Anguilla", "Antarctica", "Antigua and Barbuda", 
          "Argentina", "Armenia", "Aruba",  
          "Austria", "Azerbaijan", "Bahamas", "Bahrain", 
          "Bangladesh", "Barbados", "Belarus", "Belgium", 
          "Belize", "Benin", "Bermuda", "Bhutan", "Bolivia",
          "Bosnia and Herzegowina", "Botswana", "Bouvet Island",
          "Brazil", "British Indian Ocean Territory",
          "Brunei Darussalam", "Bulgaria", "Burkina Faso",
          "Burundi", "Cambodia", "Cameroon", 
          "Cape Verde", "Cayman Islands", "Central African Republic", 
          "Chad", "Chile", "China", "Christmas Island", 
          "Cocos (Keeling) Islands", "Colombia", "Comoros", 
          "Congo", "Congo, (DRC)", 
          "Cook Islands", "Costa Rica", "Cote d'Ivoire", 
          "Croatia (Hrvatska)", "Cuba", "Cyprus", "Czech Republic", 
          "Denmark", "Djibouti", "Dominica", "Dominican Republic", 
          "East Timor", "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea", 
          "Eritrea", "Estonia", "Ethiopia", "Falkland Islands (Malvinas)", 
          "Faroe Islands", "Fiji", "Finland", "France", "France Metropolitan", 
          "French Guiana", "French Polynesia", "French Southern Territories", 
          "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Gibraltar", 
          "Greece", "Greenland", "Grenada", "Guadeloupe", "Guam", 
          "Guatemala", "Guinea", "Guinea-Bissau", "Guyana", "Haiti", 
          "Heard and Mc Donald Islands", "Holy See (Vatican City State)", 
          "Honduras", "Hong Kong", "Hungary", "Iceland", "India", "Indonesia", 
          "Iran (Islamic Republic of)", "Iraq", "Israel", "Italy", 
          "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Kiribati", 
          "North Korea (DPRK)", "South Korea (ROK)", 
          "Kuwait", "Kyrgyzstan", "Lao, People's Democratic Republic", 
          "Latvia", "Lebanon", "Lesotho", "Liberia", "Libyan Arab Jamahiriya", 
          "Liechtenstein", "Lithuania", "Luxembourg", "Macau", 
          "Macedonia", "Madagascar", "Malawi", 
          "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", 
          "Martinique", "Mauritania", "Mauritius", "Mayotte", "Mexico", 
          "Micronesia, Federated States of", "Moldova, Republic of", 
          "Monaco", "Mongolia", "Montserrat", "Morocco", "Mozambique", 
          "Myanmar", "Namibia", "Nauru", "Nepal", "Netherlands", 
          "Netherlands Antilles", "New Caledonia", "New Zealand", "Nicaragua", 
          "Niger", "Nigeria", "Niue", "Norfolk Island", "Northern Mariana Islands", 
          "Norway", "Oman", "Pakistan", "Palau", "Panama", "Papua New Guinea", 
          "Paraguay", "Peru", "Philippines", "Pitcairn", "Poland", 
          "Portugal", "Puerto Rico", "Qatar", "Reunion", "Romania", 
          "Russian Federation", "Rwanda", "Saint Kitts and Nevis", 
          "Saint Lucia", "Saint Vincent and the Grenadines", "Samoa", 
          "San Marino", "Sao Tome and Principe", "Saudi Arabia", 
          "Senegal", "Seychelles", "Sierra Leone", "Singapore", 
          "Slovakia (Slovak Republic)", "Slovenia", "Solomon Islands", 
          "Somalia", "South Africa", "South Georgia / South Sandwich Is.", 
          "Spain", "Sri Lanka", "St. Helena", "St. Pierre and Miquelon", 
          "Sudan", "Suriname", "Svalbard and Jan Mayen Islands", "Swaziland", 
          "Sweden", "Switzerland", "Syrian Arab Republic", 
          "Taiwan, Province of China", "Tajikistan", "Tanzania, United Republic of", 
          "Thailand", "Togo", "Tokelau", "Tonga", "Trinidad and Tobago", "Tunisia", 
          "Turkey", "Turkmenistan", "Turks and Caicos Islands", "Tuvalu", "Uganda", 
          "Ukraine", "United Arab Emirates",  
          "United States Minor Outlying Islands", "Uruguay", "Uzbekistan", "Vanuatu", 
          "Venezuela", "Vietnam", "Virgin Islands (British)", "Virgin Islands (U.S.)", 
          "Wallis and Futuna Islands", "Western Sahara", "Yemen", "
          Yugoslavia", "Zambia", "Zimbabwe"]
          
    return_arr = []
    arr.each do |item|
      return_arr << [item, item]
    end
    return_arr
  end



end
