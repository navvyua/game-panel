class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.config.email_from
end
