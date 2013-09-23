require 'spec_helper'

class FakeInvoice
  attr_accessor :payments, :state, :user, :amount, :invoice_end_date
end

describe Subscriptions::BillCollector do

  let(:payment_gateway) { double() }
  let(:payment) { double("Payment") }

  let(:credit_card) { double() }
  let(:user) {
    user = double()
    user.stub(:credit_card) { credit_card }
    user
  }

  let(:amount) { 12345 }
  let(:pending_invoice) {
    f_invoice = FakeInvoice.new
    f_invoice.invoice_end_date = invoice_end_date
    f_invoice.state= :pending
    f_invoice.user = user
    f_invoice.amount = amount
    f_invoice.payments = []
    f_invoice
  }

  subject {
    Subscriptions::BillCollector.new(payment_gateway)
  }

  describe ".collect" do

    let(:invoice_end_date) { Date.today }

    before {
      payment.should_receive(:is_successful?) { payment_status }
      payment_gateway.should_receive(:authorize_and_capture)
                     .with(credit_card, amount)

      subject.should_receive(:generate_payment) { payment }

      subject.collect pending_invoice
    }

    context "when payment successful" do
      let(:payment_status) { true }
      it "state should change complete" do
        pending_invoice.state.should eq(:complete)
      end
      it "payment should be added to invoice" do
        pending_invoice.payments.size.should eq(1)
      end
    end

    context "when payment unsuccessful" do
      let(:payment_status) { false }
      it "state should remain as pending" do
        pending_invoice.state.should eq(:pending)
      end
      it "payment should be added to invoice" do
        pending_invoice.payments.size.should eq(1)
      end
    end
  end


  describe ".add_payment" do
    let(:invoice_end_date) { Date.today }

    context "successful payment" do
      before {
        payment.should_receive(:is_successful?) { true }
        subject.add_payment(pending_invoice, payment)
      }

      it "should add payment" do
        pending_invoice.payments.count.should eq(1)
      end

      it "should change the state to 'complete' if the balance was settled" do
        pending_invoice.state.should eq(:complete)
      end
    end

    context "unsuccessful payment" do

      before {
        payment.should_receive(:is_successful?) { false }
        subject.add_payment(pending_invoice, payment)
      }

      it "should still add a payment if it was unsuccessful" do
        pending_invoice.payments.count.should eq(1)
      end

      it "should not change the state if the payment was unsuccessful" do
        pending_invoice.state.should eq(:pending)
      end
    end
  end

end
