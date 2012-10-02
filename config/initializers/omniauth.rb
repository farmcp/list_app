Rails.application.config.middleware.use OmniAuth::Builder do
  consumer_key = ENV['FB_KEY'] || '502583739757983'
  consumer_secret = ENV['FB_SECRET'] || 'c6d07b598886de3eea30dda827ea2890'
  provider :facebook, consumer_key, consumer_secret
end
