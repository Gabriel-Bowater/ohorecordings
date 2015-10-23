class AppMailer < ActionMailer::Base
 
  default from: 'ohobot@ohorecordings.com'
 
  def welcome_email(user)
    @user = user
    @confirm_code = SecureRandom.hex
    user.update(confirm_code: @confirm_code)
    @link = "www.ohorecordings.com/users/#{@user.id}/confirm/#{@confirm_code}"
    mail(to: @user.email, subject: "Welcome!")
  end

  def recovery_email(user)
  	@user = user
  	@confirm_code = SecureRandom.hex
  	user.update(confirm_code: @confirm_code)
  	@link = "www.ohorecordings.com/users/#{@user.id}/reset/#{@confirm_code}"
  	mail(to: @user.email, subject: "Password reset.")
  end
end