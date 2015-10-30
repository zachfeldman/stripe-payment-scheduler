# Stripe Payment Scheduler

Here's a simple Sinatra app that lets you schedule payments based off of customers already in your Stripe account with default cards. This is different than subscription billing - this app has a Rakefile that must be run each day for payments to be processed.

The Rakefile provides a task that can run each day to process payments and e-mails a CSV report of what payments are processed to your chosen address.

I provide no warranty for this software and absolve myself of any issues that happen because of it. I'm simply trying to provide a simple boilerplate for those looking for something like this.