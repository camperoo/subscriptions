module Subscriptions
  class CreditCard < ActiveRecord::Base
    belongs_to :customer, class_name: Subscriptions.customer_class
  end
end
