module Subscriptions
  module Services
    class PaymentGateway

      MERCHANT_FEE_PERCENTAGE = 0.0275

      def authorize_and_capture(cim_gateway, credit_card, amount)
        gateway_result = cim_gateway.create_customer_profile_transaction

        payment_data = {}
        payment_data[:merchant_fee_percentage] = MERCHANT_FEE_PERCENTAGE
        payment_data[:merchant_fee] = amount * MERCHANT_FEE_PERCENTAGE
        payment_data[:gateway_fee_percentage] = gateway_result[:gateway_fee_percentage]
        payment_data[:gateway_fee] = amount * gateway_result[:gateway_fee_percentage]
        payment_data
      end

    end
  end
end
