module Subscriptions
  class EventLogger

    def self.log_charge(payment, user, amount, data, source)
      log(payment, user, "was charged", amount, data, "charge", source)
    end

    private

    def self.log(payment, user, action, amount, data, type, source)
      return nil if payment.event

      event = Subscriptions::Event.new

      event.payment = payment
      event.user_identifier = user
      event.action = action
      event.amount = amount
      event.data = data
      event.event_type = type
      event.source = source

      event.save!

      event
    end
  end
end
