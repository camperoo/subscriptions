module Subscriptions
  module Services
    class BillCollector
      extend Forwardable

      #these get forwarded to the ActiveRecord invoice object.
      def_delegators :@invoice, :payments, :state, :state=, :credit_card, :amount,
                                :invoice_end_date

      def initialize(invoice)
        @invoice = invoice
      end

      def collect_if_due(billing_service)
        return unless invoice_end_date == Date.today

        # TODO - The invoice won't have the credit_card, so we should get the 
        # user from the invoice instead and get the credit_card from the
        # user to pass in here. - Javid
        payment = billing_service.authorize_and_capture(credit_card, amount)
        add_payment(payment)
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
