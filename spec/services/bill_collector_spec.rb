require 'spec_helper'
require 'active_merchant'

ActiveMerchant::Billing::Base.mode = :test

shared_context "vcr_setup" do
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
end

describe Subscriptions::BillCollector do

  include_context "vcr_setup"

  let(:user) {
    user = double(Subscriptions.customer_class)
    user.stub(:credit_card) { credit_card }
    user
  }

  let(:pending_invoice) {
    f_invoice = Subscriptions::Invoice.new
    f_invoice.invoice_end_date = invoice_end_date
    f_invoice.status = :pending
    f_invoice.stub(:customer) { user }
    f_invoice.amount = amount
    f_invoice.payments = []
    f_invoice
  }

  subject {
    Subscriptions::BillCollector.new(gateway)
  }

  describe ".collect" do
    let(:invoice_end_date) { Date.today }

    context "when payment is successful" do
      before {
        VCR.use_cassette('create_customer_profile_transaction') do
          subject.collect(pending_invoice)
        end
      }

      it "should be added to the invoice " do
        pending_invoice.payments.size.should eq(1)
      end

      it "invoice status should be complete" do
        pending_invoice.status.should eq(:complete)
      end

      it "should be successful" do
        payment = pending_invoice.payments.first

        payment.is_successful?.should be_true
        payment.amount.should eq(1.23)
      end

    end

    context "when payment unsuccessful" do
      before {
        VCR.use_cassette('create_customer_profile_transaction_bad') do
          subject.collect(pending_invoice)
        end
      }

      it "should be added to the invoice " do
        pending_invoice.payments.size.should eq(1)
      end

      it "invoice status should be failed" do
        pending_invoice.status.should eq(:failed)
      end

      it "should not be successful" do
        payment = pending_invoice.payments.first

        payment.is_successful?.should be_false
        payment.amount.should be_nil
      end

      it "should track the number of retries" do
        pending_invoice.retries.should eq(1)

        VCR.use_cassette('create_customer_profile_transaction_bad') do
          subject.collect(pending_invoice)
        end

        pending_invoice.retries.should eq(2)
        pending_invoice.payments.size.should eq(2)
      end
    end
  end
end
