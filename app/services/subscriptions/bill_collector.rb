module Subscriptions
  class BillCollector
    extend Forwardable

    def initialize(payment_gateway)
      @payment_gateway = payment_gateway
    end

    def collect(invoice)
      return if invoice.retries >= 3

      gateway_response = @payment_gateway.authorize_and_capture(
                                            invoice.customer.credit_card,
                                            invoice.amount)

      payment = generate_payment(gateway_response)

      add_payment(invoice, payment)
    end

    def add_payment(invoice, payment)
      if payment.is_successful?
        invoice.status = :complete
      else
        invoice.status = :failed
        invoice.retries += 1
      end

      invoice.payments << payment
    end

    private

    def generate_payment(response)
      payment = Subscriptions::Payment.new
      payment.status = response["messages"]["result_code"]

      if payment.is_successful?
        raw_data = response["direct_response"]

        payment.amount = raw_data["amount"].to_f
        payment.description = raw_data["message"]
        payment.customer_id = raw_data["customer_id"]
      else
        raw_data = response["messages"]
        payment.description = raw_data["text"]
      end

      payment
    end

  end
end
