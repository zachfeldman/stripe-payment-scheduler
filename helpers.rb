def find_stripe_customer_by_email(email)
  all_customers = Stripe::Customer.all
  all_customers.select{|customer| customer.email == email}.first
end