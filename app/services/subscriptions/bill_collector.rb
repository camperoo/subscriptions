module Subscriptions
  class BillCollector
    extend Forwardable

    def initialize(payment_gateway)
      @payment_gateway = payment_gateway
    end

    def collect(invoice)
      gateway_response = @payment_gateway.authorize_and_capture(invoice.customer.credit_card, invoice.amount)

      payment = generate_payment(gateway_response)

      add_payment(invoice, payment)
    end

    def create_payment_from_response(gateway_response)
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
      Subscriptions::Payment.generate_from_response(response)
    end

  end
end
