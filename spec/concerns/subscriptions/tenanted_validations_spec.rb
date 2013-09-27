require 'spec_helper'

Temping.create :dummy_class do
  include Subscriptions::TenantedValidations

  with_columns do |t|
    t.integer :tenant_id
  end

end

describe Subscriptions::TenantedValidations do
  context "tenanting is enabled" do
    let(:tenanted) { DummyClass.new }

    before {
      Subscriptions.tenanting_enabled = true
    }

    it "has the tenant_id validation" do
      tenanted.should_not be_valid
    end
  end

  context "tenanting is disabled" do
    let(:tenanted) { DummyClass.new }

    before {
      Subscriptions.tenanting_enabled = false
    }

    it "does not have the tenant_id validation" do
      tenanted.should be_valid
    end
  end


end
