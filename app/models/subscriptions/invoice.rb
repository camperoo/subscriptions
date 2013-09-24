module Subscriptions
  class Invoice < ActiveRecord::Base
    belongs_to :customer, class_name: Subscriptions.customer_class
    has_many :payments

    scope :due_today, -> { where(invoice_end_date: Date.today)
                           .where(status: :pending)}

    scope :to_retry, -> { where("retries > ?",  0)
                         .where("retries < ?", 4)
                         .where(status: :failed) }
  end
end
