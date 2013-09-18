module Subscriptions
  class Event < ActiveRecord::Base
    belongs_to :payment
  end
end
