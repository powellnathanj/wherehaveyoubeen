require 'ritehere'
run Sinatra::Application.set(
 ENV['RACK_ENV']  = 'development'
)
