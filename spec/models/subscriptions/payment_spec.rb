require 'spec_helper'
require 'active_merchant'

ActiveMerchant::Billing::Base.mode = :test

describe Subscriptions::Payment do

  describe ".is_successful?" do
    it "should return true if status is 'Ok'" do
      subject.status = "Ok"
      subject.is_successful?.should be_true
    end

    it "should return false if status anything but 'Ok'" do
      subject.status = "foo"
      subject.is_successful?.should be_false
    end
  end
end
