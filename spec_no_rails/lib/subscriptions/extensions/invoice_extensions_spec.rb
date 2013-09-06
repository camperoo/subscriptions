require 'subscriptions/extensions/invoice_extensions'

class Invoice
  include Subscriptions::Extensions::InvoiceExtensions

  attr_accessor :payments, :state

  def initialize
    self.payments = []
    self.state = :pending
  end

end

describe Invoice do

  let(:billing_service) { double() }

  context "when due date in the future" do

    describe ".collect_if_due" do
      it "shouldn't collect money or change state" do
        subject.should_receive(:invoice_end_date) { Date.today + 1 }
        subject.should_not_receive(:set_state)
        subject.should_not_receive(:add_payment)
        subject.collect_if_due billing_service
      end
    end

  end

  context "when due date is today" do
    let(:credit_card) { double() }
    let(:amount) { 12345 }
    let(:payment) { double() }


    describe ".collect_if_due" do
      it "should collect money and change state to complete when successful" do
        subject.should_receive(:invoice_end_date) { Date.today }
        subject.should_receive(:credit_card) { credit_card }
        subject.should_receive(:amount) { amount }
        subject.should_receive(:set_state).with(:complete)
        subject.should_receive(:add_payment).with(payment)

        billing_service.should_receive(:authorize_and_capture)
          .with(credit_card, amount) { payment }

        subject.collect_if_due billing_service
      end

      it "should not collect money or change state when unsuccessful" do
        pending
#        subject.should_receive(:invoice_end_date) { Date.today }
#        subject.should_receive(:credit_card) { credit_card }
#        subject.should_receive(:amount) { amount }
#        subject.should_not_receive(:set_state)
#        subject.should_receive(:add_payment).with(payment)
#
#        billing_service.should_receive(:authorize_and_capture)
#          .with(credit_card, amount) { payment }
#
#        subject.collect_if_due billing_service
      end
    end
  end

  describe ".add_payment" do
    let (:payment) { double() }

    context "successful payment" do
      before {
        payment.should_receive(:status) { :success }
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
        payment.should_receive(:status) { :failed }
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
