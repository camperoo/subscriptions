require 'spec_helper'

describe Subscriptions::EventLogger do
  describe "new_charge_log" do
    let(:customer) { FactoryGirl.create(:customer) }
    let(:invoice) { FactoryGirl.create(:invoice, customer: customer) }
    let(:payment) { FactoryGirl.create(:payment, invoice: invoice, customer: customer ) }

    it "should log a new charge with all data" do
      EventLogger.log(payment.id, payment.customer.email, "charged", payment.amount, "some raw data", "charge", "Authorize.net")

      generated_event = payment.event

      generated_event.payment.id.should eq(payment.id)
      generated_event.user.should eq(payment.customer.email)
      generated_event.action.should eq("charged")
      generated_event.amount.should eq(payment.amount)
      generated_event.data.should eq("some raw data")
      generated_event.type.should eq("charge")
      generated_event.source.should eq("Authorize.net")

    end
  end
end
