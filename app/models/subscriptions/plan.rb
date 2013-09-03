module Subscriptions
  class Plan < ActiveRecord::Base
    belongs_to :group
  end
end
