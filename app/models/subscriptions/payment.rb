module Subscriptions
  class Payment < ActiveRecord::Base

    STATUSES = [
      STATUS_COMPLETE = :complete,
      STATUS_ERROR = :error
    ]

    # Relationships
    belongs_to :customer, class_name: Subscriptions.customer_class
    belongs_to :invoice
    has_one :event

    # Validations
    validates_inclusion_of :status, :in => STATUSES,
                           :message => "{{value}} must be one of: #{STATUSES.join ', '}"

    # Methods
    def is_successful?
      return self.status == STATUS_COMPLETE
    end

  end
end
