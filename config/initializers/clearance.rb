Clearance.configure do |config|
  config.cookie_expiration = lambda { 1.year.from_now.utc }
  config.mailer_sender = 'info@sharepractice.com'
  config.user_model = User
end