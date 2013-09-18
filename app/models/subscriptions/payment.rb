module Subscriptions
  class Payment < ActiveRecord::Base
    belongs_to :customer, class_name: Subscriptions.customer_class
    belongs_to :invoice
    has_one :event
  end
end
