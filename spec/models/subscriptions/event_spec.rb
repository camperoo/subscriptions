require 'spec_helper'

describe Subscriptions::Event do
  it { should respond_to(:tenant_id) }
  it { should belong_to(:payment) }
end
