module Subscriptions
  class Invoice < ActiveRecord::Base
    belongs_to :customer, class_name: Subscriptions.customer_class
    has_many :payments

    scope :due_today, -> { where(invoice_end_date: Date.today) }
  end
end
