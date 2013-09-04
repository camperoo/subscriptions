module Subscriptions
  module Extensions
    module InvoiceExtensions

      def collect_if_due(billing_service)
        if invoice_end_date == Date.today
          payment = billing_service.authorize_and_capture(
                                    credit_card,
                                    amount)
          
          add_payment(payment)

          set_state :complete
        end

      end

      def add_payment(payment)
        if payment.status == :success
          self.state = :complete
        end

        payments << payment
      end

    end
  end
end
