class UserMailer < ActionMailer::Base
  default from: "info@bitelist.com"

  # send the user a welcome email
  def welcome_email(user)
    @user = user
    @url = 'http://bitelist.com/signin'

    mail(to: user.email, subject: "Welcome to Bitelist!")
  end

  # send the user a password reset email
  def password_reset(user)
    @user = user
    mail(to: user.email, subject: "Bitelist Password Reset")
  end

  # mail followed user
  def mail_followed_user(user, other_user)
    @user = user
    @other_user = other_user
    mail(to: other_user.email, subject: "You have a new follower on Bitelist!")
  end

  def invite_user(user, new_user_email)
    @user = user
    mail(to: new_user_email, subject: user.full_name + " invited you to Bitelist!")
  end

  def request_github_access(user, git_handle)
    @user = user
    mail(to:'farm.cp@gmail.com', subject: git_handle + ' is requesting access to Github repo.')
  end
end
