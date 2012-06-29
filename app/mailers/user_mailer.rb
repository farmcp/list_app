class UserMailer < ActionMailer::Base
  default from: "info@bitelist.com"

  def welcome_email(user)
    @user = user
    @url = 'http://www.bitelist.com/signin'

    mail(to: user.email, subject: "Welcome to Bitelist")
  end


end
