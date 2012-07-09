class UserMailer < ActionMailer::Base
  default from: "info@bitelist.com"

  #send the user a welcome email
  def welcome_email(user)
    @user = user
    @url = 'http://www.bitelist.com/signin'

    mail(to: user.email, subject: "Welcome to Bitelist")
  end

  #send the user a password reset email
  def password_reset(user)
    @user = user
    mail(to: user.email, subject: "Bitelist Password Reset")
  end
end
