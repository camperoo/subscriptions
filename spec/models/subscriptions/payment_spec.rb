require 'spec_helper'
require 'active_merchant'

ActiveMerchant::Billing::Base.mode = :test

describe Subscriptions::Payment do
  describe ".generate_from_response" do

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
      ActiveMerchant::Billing::AuthorizeNetCimGateway.new( login: login,
                                                        password: password )
    }

    let(:gateway) { Subscriptions::PaymentGateway.new(cim_gateway) }

    it "generates a payment from a successful response" do

      VCR.use_cassette('create_customer_profile_transaction') do
        @payment_data = gateway.authorize_and_capture(credit_card, amount)
      end

      payment = Subscriptions::Payment.generate_from_response(@payment_data)

      payment.should_not be_nil
      payment.status.should eq("Ok")
      payment.amount.should eq(1.23)
      payment.description.should eq(@payment_data["direct_response"]["message"])

    end
  end

  describe ".is_successful?" do
    it "should return true if status is 'Ok'" do
      subject.status = "Ok"
      subject.is_successful?.should be_true
    end

    it "should return false if status anything but 'Ok'" do
      subject.status = "foo"
      subject.is_successful?.should be_false
    end
  end
end
