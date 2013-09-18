require 'subscriptions/services/payment_gateway.rb'
require 'active_merchant'
require 'spec_no_rails_helper'

ActiveMerchant::Billing::Base.mode = :test

describe Subscriptions::Services::PaymentGateway do

  describe "authorize_and_capture" do
    GATEWAY_FEE_PERCENTAGE = 0.021
    MERCHANT_FEE_PERCENTAGE = 0.0275

    let(:amount) { 123 }
    let(:credit_card) {
      credit_card = double()
      credit_card.stub(:customer_profile_id) { "20851995" }
      credit_card.stub(:customer_payment_profile_id) { "19136816" }
      credit_card
    }
    let(:login) { "SOMETRANSACTIONNAME" }
    let(:password) { "SOMETRANSACTIONKEY" }
    let(:cim_gateway) {
      ActiveMerchant::Billing::AuthorizeNetCimGateway.new( login: login, password: password )
    }

    it "returns a payment when successful on a non-existing user" do

      VCR.use_cassette('create_customer_profile_transaction') do
        @payment_data = subject.authorize_and_capture(cim_gateway, credit_card, amount)
      end

      @payment_data["email_address"].should eq("test@test.com")
      @payment_data["transaction_id"].should eq("2198546730")
      @payment_data["amount"].should eq("1.23")
    end
  end

end
