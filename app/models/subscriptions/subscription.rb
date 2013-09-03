module Subscriptions
  class Subscription < ActiveRecord::Base
    belongs_to :plan
    belongs_to :customer
  end
end
