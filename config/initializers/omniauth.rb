Rails.application.config.middleware.use OmniAuth::Builder do
  consumer_key = '502583739757983'
  consumer_secret = 'c6d07b598886de3eea30dda827ea2890'
  provider :facebook, consumer_key, consumer_secret
end