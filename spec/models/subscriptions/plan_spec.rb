require 'spec_helper'

describe Subscriptions::Plan do
  it { should respond_to(:tenant_id) }

  it { should validate_presence_of(:amount) }
  it { should validate_numericality_of(:amount) }

  it { should validate_presence_of(:interval_units) }
  it { should validate_presence_of(:interval_quantity) }
  it { should validate_presence_of(:name) }

  it { should ensure_inclusion_of(:interval_units).in_array(Subscriptions::Plan::INTERVAL_UNITS) }
  it { should_not allow_value("bla").for(:interval_units) }

  describe ".description" do
    it "should show the correct description for one interval" do
      plan  = FactoryGirl.create(:plan, amount: 100, interval_quantity: 1,
                                             interval_units: :month)

      plan.description.should eq("$100.0 / month")
    end

    it "should show the correct description for one interval" do
      plan  = FactoryGirl.create(:plan, amount: 100, interval_quantity: 2,
                                             interval_units: :month)

      plan.description.should eq("$100.0 every 2 months")
    end
  end
end
