module Subscriptions
  class Invoice < ActiveRecord::Base
    belongs_to :customer, class_name: Subscriptions.customer_class
    has_many :payments

    scope :due_today, -> { where(invoice_end_date: Date.today)
                           .where(status: :pending)}

    scope :to_retry, -> { where("retries > ?",  0)
                         .where("retries < ?", 4)
                         .where(status: :failed) }

    def add_payment(payment)
      if payment.is_successful?
        self.status = :complete
      else
        self.status = :failed
        self.retries += 1
      end

      self.payments << payment
    end

  end
end
