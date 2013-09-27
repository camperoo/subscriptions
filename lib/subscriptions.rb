require "subscriptions/engine"

module Subscriptions
  mattr_accessor :customer_class
  mattr_accessor :tenanting_enabled

  def self.customer_class
    @@customer_class.constantize
  end

  def self.tenanting_enabled
    enabled = false
    if @@tenanting_enabled
      enabled = true
    end

    enabled
  end
end
