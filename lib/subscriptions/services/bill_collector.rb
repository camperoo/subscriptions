module Subscriptions
  module Services
    class BillCollector
      extend Forwardable

      def initialize(payment_gateway)
        @payment_gateway = payment_gateway
      end

      def collect_if_due(invoice)
        return unless invoice.invoice_end_date == Date.today

        payment = @payment_gateway.authorize_and_capture(invoice.user.credit_card, invoice.amount)
        add_payment(invoice, payment)
      end

      def add_payment(invoice, payment)
        if payment.is_successful?
          invoice.state= :complete
        end
        invoice.payments << payment
      end

    end
  end
end
