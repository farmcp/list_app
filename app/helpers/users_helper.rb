module UsersHelper
  def gravatar_for(user, options = {size:'50'})
    gravatar_class = "gravatar"
    if user.image_url
      image_tag(user.image_url, alt: user.full_name.to_s, class: gravatar_class, size: options[:size])
    else
      
      gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
      gravatar_url = "http://gravatar.com/avatar/#{gravatar_id}.png?r=r&size=#{options[:size]}"
      image_tag(gravatar_url, alt: user.full_name.to_s, class: gravatar_class, :gravatar => options)
    end
  end
end
