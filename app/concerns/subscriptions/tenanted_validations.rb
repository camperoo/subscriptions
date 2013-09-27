module Subscriptions
  module TenantedValidations
    extend ActiveSupport::Concern

    included do
      validates :tenant_id, presence: true, if: -> { Subscriptions.tenanting_enabled }
      validate :tenant_id_is_not_set, unless: -> { Subscriptions.tenanting_enabled }
    end

    def tenant_id_is_not_set
      if tenant_id.present?
        errors.add(:tenant_id, "should not be set")
      end
    end

  end
end
