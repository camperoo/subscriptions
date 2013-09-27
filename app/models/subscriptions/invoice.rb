module Subscriptions
  class Invoice < ActiveRecord::Base

    include Subscriptions::TenantedValidations

    STATUSES = [
      STATUS_PENDING = :pending,
      STATUS_COMPLETE = :complete,
      STATUS_FAILED = :failed
    ]

    belongs_to :customer, class_name: Subscriptions.customer_class
    has_many :payments

    scope :due_today, -> { where(invoice_end_date: Date.today)
                           .where("status = ?", :pending)}

    scope :to_retry, -> { where("retries > ?",  0)
                         .where("retries < ?", 3)
                         .where("status = ?", :failed)}

    def add_payment(payment)
      if payment.is_successful?
        self.status = STATUS_COMPLETE
      else
        self.status = STATUS_FAILED
        self.retries += 1
      end

      self.payments << payment
      self.save!
    end

  end
end
