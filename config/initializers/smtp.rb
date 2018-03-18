ActionMailer::Base.smtp_settings = {
  enable_starttls_auto: true,
  address: ENV['SMTP_ADDRESS'],
  domain: ENV['SMTP_DOMAIN'],
  port: 587,
  authentication: :login,
  user_name: ENV['SMTP_USERNAME'],
  password: ENV['SMTP_PASSWORD']
}
