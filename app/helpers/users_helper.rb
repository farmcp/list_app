module UsersHelper
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  def avatar_tag(user, options = {})
    size = options.delete(:size) { 50 }
    link = options.delete(:link) { false }
    link_to user do
      image_tag(user.avatar_url, alt: user.full_name, class: 'gravatar', size: size)
    end
  end

  def active_unless_current_user
    current_user?(@user) ? '' : 'active'
  end

  def validate_email(email_address)
    if email_address =~ VALID_EMAIL_REGEX
      return true
    else 
      return false
    end
  end
end
