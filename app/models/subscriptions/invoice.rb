module Subscriptions
  class Invoice < ActiveRecord::Base
    belongs_to :customer
    has_many :payments
  end
end
