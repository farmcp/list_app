Rails.application.config.middleware.use OmniAuth::Builder do
  consumer_key = ENV['FB_KEY']
  consumer_secret = ENV['FB_SECRET']
  provider :facebook, consumer_key, consumer_secret, {:scope => 'publish_checkins, publish_actions, publish_stream'}
end
