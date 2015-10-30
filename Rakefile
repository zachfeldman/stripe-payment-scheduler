require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
require './app'
require 'csv'
require './mailer'

namespace :charge do
  task :days_charges do

    report_date = Date.today.strftime
    email_to = "someone@test.com"
    filename = "payments_#{Time.now}.csv"

    date_for = Date.parse(report_date)
    payments = Payment.where(date_to_run: date_for)

    payments_report = []

    if payments.count > 0
      payments.each do |payment|
        stripe_payment = Stripe::Charge.create(
          :amount => payment.amount_in_cents,
          :currency => payment.currency,
          :customer => payment.customer_id, # obtained with Stripe.js
          :description => payment.for
        )
        payments_report.push({
          date: report_date,
          email: payment.customer_email,
          for: payment.for,
          amount: payment.amount_in_cents/100,
          success: stripe_payment.paid ? "successfully" : "unsuccessfully"
        })
      end
      CSV.open("/tmp/#{filename}", "wb") do |csv|
        headers = [
          "Date",
          "Email",
          "Payment For",
          "Payment Amount",
          "Charged Successfully?"
        ]
        csv << headers

        payments_report.each do |payment_report_item|
          csv << [
            payment_report_item[:date],
            payment_report_item[:email],
            payment_report_item[:for],
            payment_report_item[:amount],
            payment_report_item[:success]
          ]
        end
      end
      attachment = File.read("/tmp/#{filename}")
      attachment_encoded = Base64.encode64(attachment)

      

      message = {
        subject: "Payments - #{report_date}",
        from_email: "from@test.com",
        from_name: "Payment Scheduler",
        to_emails:  [{
          "email"=> email_to,
          "name"=> email_to,
          "type"=>"to"
        }],
        reply_to: "from@test.com",
        content: "Payments - #{report_date}",
        attachments: [
              {
                  type: "file/csv",
                  name: filename,
                  content: attachment_encoded
              }
          ]
        }
      response = Mailer.send_mail(message)
    else
      message = {
        subject: "Payments - #{report_date}",
        from_email: "from@test.com",
        from_name: "Payment Scheduler",
        to_emails:  {
          "email"=> email_to,
          "name"=> email_to,
          "type"=>"to"
        },
        reply_to: "from@test.com",
        content: "Payments - #{report_date}<br><br>No payments today.",
        attachments: [
              {
                  type: "file/csv",
                  name: filename,
                  content: attachment_encoded
              }
          ]
        }
      response = Mailer.send_mail(message)
    end
  end
end