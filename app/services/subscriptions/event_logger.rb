module Subscriptions
  class EventLogger

    def self.log_charge(payment, email, amount, data, source, code="code", code_text="code text")
      log(payment, email, "was charged", amount, data, "charge", source, code, code_text)
    end

    private

    def self.log(payment, email, action, amount, data, type, source, code, code_text)
      return nil if payment.event

      event = Subscriptions::Event.new

      event.payment = payment
      event.user_identifier = email
      event.action = action
      event.amount = amount
      event.data = data.to_json
      event.event_type = type
      event.source = source
      event.code = code
      event.code_text = code_text

      event.save!

      event
    end
  end
end
