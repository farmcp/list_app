module UsersHelper
  def avatar_tag(user, options = {})
    size = options.delete(:size) { 50 }
    image_tag(user.avatar_url, alt: user.full_name, class: 'gravatar', size: size)
  end

  def active_unless_current_user
    current_user?(@user) ? '' : 'active'
  end
end
