require 'spec_helper'
require 'active_merchant'

ActiveMerchant::Billing::Base.mode = :test

describe Subscriptions::PaymentGateway do
  let(:login) { "SOMETRANSACTIONNAME" }
  let(:password) { "SOMETRANSACTIONKEY" }
  let(:cim_gateway) {
    ActiveMerchant::Billing::AuthorizeNetCimGateway.new( login: login,
                                                        password: password )
  }

  subject { Subscriptions::PaymentGateway.new(cim_gateway) }

  describe "authorize_and_capture" do
    let(:amount) { 1.23 }

    let(:invoice) {
      invoice = double()
      customer = double()
      invoice.stub(:customer) { customer }
      invoice.stub(:amount) { amount }
      customer.stub(:credit_card) { credit_card }
      invoice
    }

    context "with good credit card" do
      let(:credit_card) {
        credit_card = double()
        credit_card.stub(:customer_profile_id) { "20851995" }
        credit_card.stub(:customer_payment_profile_id) { "19136816" }
        credit_card
      }
      it "returns a payment when successful on an existing user" do

        VCR.use_cassette('create_customer_profile_transaction') do
          @payment_data = subject.authorize_and_capture(invoice)
        end

        direct_response = @payment_data["direct_response"]

        direct_response["email_address"].should eq("test@test.com")
        direct_response["transaction_id"].should eq("2198546730")
        direct_response["amount"].should eq("1.23")
      end
    end

    context "with bad credit card" do
      let(:credit_card) {
        credit_card = double()
        credit_card.stub(:customer_profile_id) { "20851995" }
        credit_card.stub(:customer_payment_profile_id) { "11111111" }
        credit_card
      }
      it "returns a payment when unsuccessful on an existing user" do

        VCR.use_cassette('create_customer_profile_transaction_bad') do
          @payment_data = subject.authorize_and_capture(invoice)
        end

        direct_response = @payment_data["direct_response"]

        direct_response.should be_nil
        @payment_data["messages"]["result_code"].should eq("Error")
      end
    end

  end
end
