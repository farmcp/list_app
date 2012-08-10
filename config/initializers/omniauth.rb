if Rails.env == 'development' || Rails.env =='test'
  p Rails.env
  Rails.application.config.middleware.use OmniAuth::Builder do
    consumer_key = '502583739757983'
    consumer_secret = 'c6d07b598886de3eea30dda827ea2890'
    provider :facebook, consumer_key, consumer_secret
  end
else
  p Rails.env
  Rails.application.config.middleware.use OmniAuth::Builder do
    consumer_key = '420852091284329'
    consumer_secret = '15568317829619690c4e7c8e39d25b9d'
    provider :facebook, consumer_key, consumer_secret
  end
end