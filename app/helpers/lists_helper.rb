module ListsHelper
  def fb_share_link
    current_link = request.host_with_port + request.fullpath
    fb_params = {
      a: 1,
      b: 2,
      app_id:       ENV['FB_KEY'],
      link:         @current_link,
      name:         @list.fb_share_title,
      caption:      @list.fb_share_caption,
      redirect_uri: "http://#{@current_link}",
    }.map{|key, value| "#{key}=#{value}"}.join('&')
    "https://www.facebook.com/dialog/feed?#{fb_params}"
  end
end
