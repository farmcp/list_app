module UsersHelper
  def gravatar_for(user)
    gravatar_class = "gravatar"
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "http://gravatar.com/avatar/#{gravatar_id}.png"
    image_tag(gravatar_url, alt: user.first_name.to_s + user.last_name.to_s, class: gravatar_class)
  end
end
