Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FB_KEY'], ENV['FB_SECRET'], display: 'popup', scope: 'email'
  provider :google_oauth2, ENV['GOOGLE_KEY'], ENV['GOOGLE_SECRET'], scope: 'email'
end
