require 'spec_helper'

describe Subscriptions::EventLogger do
  describe "log_charge" do
    let(:customer) { FactoryGirl.create(:customer) }
    let(:invoice) { FactoryGirl.create(:invoice, customer: customer) }
    let(:payment) { FactoryGirl.create(:payment, invoice: invoice,
                                                customer: customer ) }

    it "should create a new event with all data" do
      raw_data = "some_raw_data" * 255
      generated_event = Subscriptions::EventLogger.log_charge(payment, payment.customer.email,
                                               payment.amount, raw_data,
                                               "Authorize.net")

      generated_event.persisted?.should be_true
      generated_event.payment.id.should eq(payment.id)
      generated_event.user_identifier.should eq(payment.customer.email)
      generated_event.action.should eq("was charged")
      generated_event.amount.should eq(payment.amount)
      generated_event.data.should eq(raw_data.to_json)
      generated_event.event_type.should eq("charge")
      generated_event.source.should eq("Authorize.net")
    end

    it "should not create the event if the payment already has one associated" do
      FactoryGirl.create(:event, payment: payment)
      generated_event = Subscriptions::EventLogger.log_charge(payment, "customer", 100,
                                                   "data", "source")

      generated_event.should be_nil
    end
  end
end
