require 'spec_helper'
require 'active_merchant'

ActiveMerchant::Billing::Base.mode = :test

describe Subscriptions::Payment do

  describe ".is_successful?" do
    it "should return true if status is 'Ok'" do
      subject.status = Subscriptions::Payment::STATUS_COMPLETE
      subject.is_successful?.should be_true
    end

    it "should return false if status anything but STATUS_COMPLETE" do
      subject.status = Subscriptions::Payment::STATUS_ERROR
      subject.is_successful?.should be_false
    end
  end
end
