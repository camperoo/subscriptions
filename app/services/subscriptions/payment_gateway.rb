module Subscriptions
  class PaymentGateway

    MERCHANT_FEE_PERCENTAGE = 0.0275

    def initialize(cim_gateway)
      @cim_gateway = cim_gateway
    end

    def authorize_and_capture(credit_card, amount)
      # This gateway requires formated decimal, not cents
      amount = "%.2f" % (amount / 100.0)

      transaction = {
        transaction:
        {
          type: :auth_capture,
          amount: amount,
          customer_profile_id: credit_card.customer_profile_id,
          customer_payment_profile_id: credit_card.customer_payment_profile_id
        }
      }

      gateway_result = @cim_gateway.create_customer_profile_transaction(transaction)
      return gateway_result.params
    end
  end
end
