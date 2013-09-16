require 'subscriptions/services/payment_gateway.rb'
require 'pry'

describe Subscriptions::Services::PaymentGateway do

  describe "authorize_and_capture" do
    GATEWAY_FEE_PERCENTAGE = 0.021
    MERCHANT_FEE_PERCENTAGE = 0.0275

    let(:amount) { 123 }
    let(:credit_card) { double() }
    let(:cim_gateway) { double() }

    it "returns a payment when successful on a non-existing user" do
      cim_gateway
        .should_receive(:create_customer_profile_transaction)
        .and_return ({ gateway_fee_percentage: 0.021 })

      payment_data = subject.authorize_and_capture(cim_gateway, credit_card, amount)

      payment_data[:merchant_fee].should eq(MERCHANT_FEE_PERCENTAGE * amount)
      payment_data[:merchant_fee_percentage].should eq(MERCHANT_FEE_PERCENTAGE)
      payment_data[:gateway_fee].should eq(GATEWAY_FEE_PERCENTAGE * amount )
      payment_data[:gateway_fee_percentage].should eq(GATEWAY_FEE_PERCENTAGE)
    end
  end

end


