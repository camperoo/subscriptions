require "subscriptions/engine"

module Subscriptions
  mattr_accessor :customer_class

  def self.customer_class
    @@customer_class.constantize
  end
end
