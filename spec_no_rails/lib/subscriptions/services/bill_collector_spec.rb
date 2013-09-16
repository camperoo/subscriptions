require 'subscriptions/services/bill_collector'
require 'pry'

class FakeInvoice
  attr_accessor :payments, :state, :credit_card, :amount, :invoice_end_date
end

describe Subscriptions::Services::BillCollector do

  let(:billing_service) { double() }
  let(:credit_card) { double() }
  let(:payment) { double() }
  let(:amount) { 12345 }

  let(:pending_invoice) {
    f_invoice = FakeInvoice.new
    f_invoice.invoice_end_date = invoice_end_date
    f_invoice.state= :pending
    f_invoice.credit_card = credit_card
    f_invoice.amount = amount
    f_invoice.payments = []
    f_invoice
  }

  subject {
    Subscriptions::Services::BillCollector.new(pending_invoice)
  }

  describe ".collect_if_due" do
    context "when due date in the future" do
      let(:invoice_end_date) { Date.today + 1 }
      before {
          subject.collect_if_due billing_service
      }
      it "payment state shouldn't change from pending" do
        subject.state.should eq(:pending)
      end
      it "number of payments shouldn't change" do
        subject.payments.size.should eq(0)
      end
    end

    context "when due date is today" do
      let(:invoice_end_date) { Date.today }

      before {
        payment.should_receive(:is_successful?) { payment_status }
        billing_service.should_receive(:authorize_and_capture)
          .with(credit_card, amount) { payment }
        subject.collect_if_due billing_service
      }

      context "when payment successful" do
        let(:payment_status) { true }
        it "state should change complete" do
          subject.state.should eq(:complete)
        end
        it "payment should be added to invoice" do
          subject.payments.size.should eq(1)
        end
      end

      context "when payment unsuccessful" do
        let(:payment_status) { false }
        it "state should remain as pending" do
          subject.state.should eq(:pending)
        end
        it "payment should be added to invoice" do
          subject.payments.size.should eq(1)
        end
      end
    end
  end


  describe ".add_payment" do
    let(:invoice_end_date) { Date.today }

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