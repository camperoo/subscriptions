module Subscriptions
  class Payment < ActiveRecord::Base
    belongs_to :customer
    belongs_to :invoice
    belongs_to :card
  end
end
