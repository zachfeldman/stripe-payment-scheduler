require 'mandrill'

class Mailer

  MANDRILL_CLIENT = Mandrill::API.new

  def self.send_mail(options = {})
    message = {
      "subject"=> options[:subject],
      "from_email"=> options[:from_email],
      "from_name"=> options[:from_name],
      "to"=>  options[:to_emails],
      "headers"=> {"Reply-To"=> options[:reply_to]},
      "attachments"=> options[:attachments]
    }
    template_name = "superintendent-notification"
    template_content = [
        {
            name: "pretitle",
            content: options[:title]
        },
        {
            name: "title",
            content: options[:title]
        },
        {
            name: "body",
            content: options[:content]
        }
    ]
    async = false
    ip_pool = "Main Pool"
    result = MANDRILL_CLIENT.messages.send_template template_name, template_content, message, async, ip_pool
  end

end
