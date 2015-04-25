class ContactMailer < ActionMailer::Base
  add_template_helper(EmailHelper)
  default from: ENV["SENDER_EMAIL"]


  def contact_message(email, item, message)
    @email = email
    @item = item
    @message = message

    mail to: ENV["SENDER_EMAIL"], subject: "REPORT INQUIRY"
  end
end
