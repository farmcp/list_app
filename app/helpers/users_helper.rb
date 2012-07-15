module UsersHelper
  def gravatar_for(user, options = {size:50})
    gravatar_class = "gravatar"
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "http://gravatar.com/avatar/#{gravatar_id}.png?r=r"
    image_tag(gravatar_url, alt: user.first_name.to_s + user.last_name.to_s, class: gravatar_class)
  end

  #check to see if there are any list items in the lists
  def any_items_in_lists?(lists)
    val = Array.new

    lists.each do |list|
      val << list.list_items.any?
    end

    return val.any?
  end
end
