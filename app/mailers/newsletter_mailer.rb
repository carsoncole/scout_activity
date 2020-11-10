class NewsletterMailer < ApplicationMailer

  def newsletter_email
    @edition = params[:newsletter]
    emails = User.owner.where(email: 'carson.cole@protonmail.com').collect(&:email).join(",")
    mail to: emails, subject: @edition.subject
  end
end
