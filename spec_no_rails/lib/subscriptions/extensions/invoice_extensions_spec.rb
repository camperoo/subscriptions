require 'subscriptions/extensions/invoice_extensions'
require 'pry'

class FakeInvoice
  attr_accessor :payments, :state, :credit_card, :amount, :invoice_end_date
end

describe Subscriptions::Extensions::InvoiceExtensions do

  let(:fake_invoice) { double() }
  let(:billing_service) { double() }

  subject {
    Subscriptions::Extensions::InvoiceExtensions.new(fake_invoice)
  }

  context "when due date in the future" do
    describe ".collect_if_due" do
      it "shouldn't collect money or change state" do
        fake_invoice.should_receive(:invoice_end_date) { Date.today + 1 }
        fake_invoice.should_receive(:state) { :pending }

        subject.collect_if_due billing_service
        subject.state.should eq(:pending)
      end
    end

  end

  context "when due date is today" do


    let(:credit_card) { double() }
    let(:amount) { 12345 }
    let(:payment) { double() }

    subject {
      f_invoice = FakeInvoice.new

      f_invoice.invoice_end_date = Date.today
      f_invoice.state= :pending
      f_invoice.credit_card = credit_card
      f_invoice.amount = amount
      f_invoice.payments = []

      Subscriptions::Extensions::InvoiceExtensions.new(f_invoice)
    }

    describe ".collect_if_due" do
      it "should collect money and change state to complete when successful" do

        payment.should_receive(:is_successful?) { true }

        billing_service.should_receive(:authorize_and_capture)
          .with(credit_card, amount) { payment }

        subject.collect_if_due billing_service
        subject.state.should eq(:complete)
        subject.payments.size.should eq(1)
      end

      it "should not collect money or change state when unsuccessful" do
        subject.should_receive(:invoice_end_date) { Date.today }
        subject.should_receive(:credit_card) { credit_card }
        subject.should_receive(:amount) { amount }
        payment.should_receive(:is_successful?) { false }

        billing_service.should_receive(:authorize_and_capture)
          .with(credit_card, amount) { payment }

        subject.state.should eq(:pending)
        subject.collect_if_due billing_service
      end
    end
  end

  describe ".add_payment" do
    let (:payment) { double() }
    let(:credit_card) { double() }
    let(:amount) { 12345 }

    subject {
      f_invoice = FakeInvoice.new

      f_invoice.invoice_end_date = Date.today
      f_invoice.state= :pending
      f_invoice.credit_card = credit_card
      f_invoice.amount = amount
      f_invoice.payments = []

      Subscriptions::Extensions::InvoiceExtensions.new(f_invoice)
    }


    context "successful payment" do
      before {
        payment.should_receive(:is_successful?) { true }
        subject.add_payment(payment)
      }

      it "should add payment" do
        subject.payments.count.should eq(1)
      end

      it "should change the state to 'complete' if the balance was settled" do
        subject.state.should eq(:complete)
      end
    end

    context "unsuccessful payment" do

      before {
        payment.should_receive(:is_successful?) { false }
        subject.add_payment(payment)
      }

      it "should still add a payment if it was unsuccessful" do
        subject.payments.count.should eq(1)
      end

      it "should not change the state if the payment was unsuccessful" do
        subject.state.should eq(:pending)
      end
    end
  end

end
