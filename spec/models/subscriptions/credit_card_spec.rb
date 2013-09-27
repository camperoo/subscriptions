require 'spec_helper'

describe Subscriptions::CreditCard do
  it { should respond_to(:tenant_id) }
  it { should belong_to(:customer) }
end
