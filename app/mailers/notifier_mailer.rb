class NotifierMailer < ApplicationMailer
  default from: 'no-reply@example.com',
          return_path: 'system@example.com'

  def welcome(recipient)
    @account = recipient
    #mail(to: recipient.email_address_with_name,
    #     bcc: ["bcc@example.com", "Order Watcher <watcher@example.com>"])
    mail(to: recipient.email_address_with_name,
         bcc: ["bcc@example.com", "Order Watcher <watcher@example.com>"]) do |format|
       format.text(content_transfer_encoding: "base64")
       format.html
     end

     NotifierMailer.welcome(User.first).deliver_now # sends the email
  end
end
