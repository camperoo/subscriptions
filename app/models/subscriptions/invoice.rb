module Subscriptions
  class Invoice < ActiveRecord::Base
    belongs_to :customer, class_name: Subscriptions.customer_class
    has_many :payments
  end
end
