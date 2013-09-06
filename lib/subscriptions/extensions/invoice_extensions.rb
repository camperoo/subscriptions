module Subscriptions
  module Extensions
    class InvoiceExtensions
      extend Forwardable

      #these get forwarded to the AR invoice object.
      def_delegators :@invoice, :payments, :state, :state=, :credit_card, :amount,
                                :invoice_end_date

      def initialize(invoice)
        @invoice = invoice
      end

      def collect_if_due(billing_service)
        if invoice_end_date == Date.today
          payment = billing_service.authorize_and_capture(
                                      credit_card,
                                      amount )

          add_payment(payment)
        end

      end

      def add_payment(payment)
        if payment.is_successful?
          self.state= :complete
        end

        payments << payment
      end

    end
  end
end
