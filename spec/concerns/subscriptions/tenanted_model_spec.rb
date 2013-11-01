require 'spec_helper'

Temping.create :dummy_class do
  include Subscriptions::TenantedModel

  with_columns do |t|
    t.integer :tenant_id
  end
end

describe Subscriptions::TenantedModel do

  let(:tenanted_model) { DummyClass.new }

  context "tenanting is enabled" do

    before {
      Subscriptions.stub(:tenanting_enabled).and_return(true)
    }

    it "has the tenant_id validation" do
      tenanted_model.should be_valid
    end

    it "should allow tenant_id" do
      tenanted_model.tenant_id = 1
      tenanted_model.should be_valid
    end
  end

  context "tenanting is disabled" do

    before {
      Subscriptions.stub(:tenanting_enabled).and_return(false)
    }

    it "does not have the tenant_id validation" do
      tenanted_model.should be_valid
    end

    it "enforces not having a tenant_id" do
      tenanted_model.tenant_id = 2
      tenanted_model.should_not be_valid
    end
  end

end
