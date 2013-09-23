module Subscriptions
  class Payment < ActiveRecord::Base
    belongs_to :customer, class_name: Subscriptions.customer_class
    belongs_to :invoice
    has_one :event

    def self.generate_from_response(gateway_response)
      raw_data = gateway_response["direct_response"]

      payment = Subscriptions::Payment.new

      payment.amount = raw_data["amount"].to_f
      payment.status = gateway_response["messages"]["result_code"]
      payment.description = raw_data["message"]
      payment.customer_id = raw_data["customer_id"]

      return payment
    end

    def is_successful?
      return self.status == "Ok"
    end
  end
end
