module Subscriptions
  module TenantedValidations
    extend ActiveSupport::Concern

    included do
      validates :tenant_id, presence: true, if: -> { Subscriptions.tenanting_enabled }
    end

  end
end
