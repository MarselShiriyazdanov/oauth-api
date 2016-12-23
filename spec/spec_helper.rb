require "omniauth"

RSpec.configure do |config|
  config.order = :random
end

OmniAuth.config.test_mode = true
