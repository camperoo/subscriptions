module Subscriptions
  class Plan < ActiveRecord::Base

    INTERVAL_UNITS = [
      WEEK = "week",
      MONTH = "month",
      YEAR = "year"
    ]

    belongs_to :group

    validates :interval_units, :interval_quantity, :name, :amount, presence: true
    validates :amount, numericality: true

    validates_inclusion_of :interval_units, in: INTERVAL_UNITS,
                           :message => "{{value}} must be one of: #{INTERVAL_UNITS.join ', '}"

    def description
      quantity_string = ""
      if interval_quantity == 1
        quantity_string = "/"
      else
        quantity_string = "every #{interval_quantity}"
      end

      desc = "$#{amount} #{quantity_string} " +
              "#{interval_units.pluralize(interval_quantity)}"

      return desc
    end
  end
end
