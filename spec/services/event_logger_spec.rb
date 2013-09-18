require 'spec_helper'

describe Subscriptions::EventLogger do
  describe "new_charge_log" do
    let(:payment) { FactoryGirl.create(:payment) }

    it "should log a new charge with all data" do

      EventLogger.log(payment.id, payment.customer.email, "charged", payment.amount, "some raw data", "charge", "Authorize.net")

    end
  end
end
