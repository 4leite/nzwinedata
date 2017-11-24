if ActionMailer::Base.delivery_method == :smtp
  ActionMailer::Base.smtp_settings[:domain] = Rails.application.secrets.smtp_domain
  ActionMailer::Base.smtp_settings[:user_name] = Rails.application.secrets.smtp_user_name
  ActionMailer::Base.smtp_settings[:password] = Rails.application.secrets.smtp_password
  ActionMailer::Base.smtp_settings[:address] = Rails.application.secrets.smtp_address
  ActionMailer::Base.smtp_settings[:port] = Rails.application.secrets.smtp_port
  ActionMailer::Base.smtp_settings[:authentication] = Rails.application.secrets.smtp_authentication
  ActionMailer::Base.smtp_settings[:enable_starttls_auto] = Rails.application.secrets.smtp_enable_starttls_auto
end
