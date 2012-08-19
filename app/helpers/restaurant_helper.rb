module RestaurantHelper
  def info_window(restaurant)
    concat image_tag(restaurant.picture_url, size: 40, style: 'float:left; margin-right:15px;')
    concat content_tag('b', restaurant.name)
    concat content_tag('br')
    concat restaurant.address
    concat content_tag('br')
    concat restaurant.city_state_zip
  end
end
