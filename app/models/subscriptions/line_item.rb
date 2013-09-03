module Subscriptions
  class LineItem < ActiveRecord::Base
    belongs_to :invoice
  end
end
