require 'sinatra/activerecord'
require 'haml'
require 'will_paginate'
require 'will_paginate/active_record'

require 'sinatra/base'
require 'rack-flash'
enable :sessions
use Rack::Flash

require "stripe"

Stripe.api_key = ENV['STRIPE_KEY']

db = YAML.load(ERB.new(File.read(File.join("database.yml"))).result)
ActiveRecord::Base.establish_connection(db[Sinatra::Base.environment.to_s])

require './payment'