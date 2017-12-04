require './config/application'
require 'rack/cors'

use OTR::ActiveRecord::ConnectionManagement


use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: :any
  end
end

run Rack::Cascade.new([
  SopService::V2,
])
