Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, APP_CONFIG[:facebook]['app_id'], APP_CONFIG[:facebook]['app_secret'],
           { scope: 'public_profile,email', info_fields: 'email,name', display: 'page' }
end
