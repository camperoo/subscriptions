require 'spec_helper'

describe Subscriptions::Subscription do
  it { should respond_to(:tenant_id) }
end
