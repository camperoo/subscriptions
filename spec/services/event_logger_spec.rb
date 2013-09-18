require 'spec_helper'

describe Subscriptions::EventLogger do
  describe "new_charge_log" do
    let(:customer) { FactoryGirl.create(:customer) }
    let(:invoice) { FactoryGirl.create(:invoice, customer: customer) }
    let(:payment) { FactoryGirl.create(:payment, invoice: invoice, customer: customer ) }

    it "should log a new charge with all data" do

      EventLogger.log(payment.id, payment.customer.email, "charged", payment.amount, "some raw data", "charge", "Authorize.net")

    end
  end
end
