require "subscriptions/engine"

module Subscriptions
  mattr_reader :customer_class
  mattr_accessor :tenanting_enabled
  mattr_accessor :current_tenant

  def self.customer_class=(klass)
    @@customer_class = klass.constantize if klass
  end

  def self.setup
    yield self
  end

  def self.model_names
    [ self.customer_class,
      Subscriptions::CreditCard,
      Subscriptions::Event,
      Subscriptions::Group,
      Subscriptions::Invoice,
      Subscriptions::LineItem,
      Subscriptions::Payment,
      Subscriptions::Plan,
      Subscriptions::Subscription]
  end

  private

  def self.reset_config
    self.tenanting_enabled = false
    self.customer_class = nil
    self.current_tenant = lambda { |request, params| nil }
  end

  reset_config
end
