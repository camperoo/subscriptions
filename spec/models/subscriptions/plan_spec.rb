require 'spec_helper'

describe Subscriptions::Plan do
  it { should respond_to(:tenant_id) }
end
