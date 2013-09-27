require "subscriptions/engine"

module Subscriptions
  mattr_accessor :customer_class
  mattr_accessor :tenanting_enabled

  def self.customer_class
    @@customer_class.constantize
  end

  def self.tenanting_enabled
    @@tenanting_enabled ? true : false
  end

end
