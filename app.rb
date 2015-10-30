require 'sinatra'
require './config'
require './helpers'

get "/" do
  haml :home
end

get "/lookup" do
  @customer = find_stripe_customer_by_email(params[:email])
  haml :customer
end

post "/setup_payment" do
  Payment.create({
    customer_email: params["customer_email"],
    customer_id: params["customer_id"],
    date_to_run: params["date"],
    amount_in_cents: params["payment_amount"].to_i*100,
    for: params["payment_for"],
    currency: params["currency"]
  })
  redirect "/success"
end

get "/success" do
  haml :success
end

get "/index" do
  @payments = Payment.paginate(page: params[:page], per_page: 10)
  haml :index
end

get "/delete/:id" do
  Payment.find(params[:id]).delete
  flash[:notice] = "Payment deleted."
  redirect "/"
end