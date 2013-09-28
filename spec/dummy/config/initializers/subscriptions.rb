Subscriptions.setup do |config|
  config.customer_class = "User"
  config.tenanting_enabled = false
  config.current_tenant = lambda { 1 }
end
