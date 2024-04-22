class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch("SMTP_USERNAME")
  layout "mailer"
end
