require 'spec_helper'

describe Subscriptions::LineItem do
  it { should belong_to(:invoice) }
  it { should respond_to(:tenant_id) }
end
