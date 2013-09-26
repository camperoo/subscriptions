module Subscriptions
  class BillCollector
    extend Forwardable

    def initialize(payment_gateway)
      @payment_gateway = payment_gateway
    end

    def collect(invoice)
      return if invoice.retries >= 3
      gateway_response = @payment_gateway.authorize_and_capture(invoice)
      payment = generate_payment(gateway_response)

      status_code = gateway_response["messages"]["message"]

      EventLogger.log_charge(payment, invoice.customer.email, payment.amount,
                             gateway_response, "AuthorizeNetCimGateway",
                             status_code["code"],  status_code["text"])

      invoice.add_payment(payment)
    end

    private

    def generate_payment(response)
      payment = Subscriptions::Payment.new

      if response["messages"]["result_code"] == "Ok"
        payment.status = Subscriptions::Payment::STATUS_COMPLETE
      else
        payment.status = Subscriptions::Payment::STATUS_ERROR
      end

      if payment.is_successful?
        raw_data = response["direct_response"]
        payment.amount = raw_data["amount"].to_f
        payment.description = raw_data["message"]
        payment.customer_id = raw_data["customer_id"]
      else
        raw_data = response["messages"]
        payment.description = raw_data["text"]
      end

      payment.save!

      payment
    end

  end
end
