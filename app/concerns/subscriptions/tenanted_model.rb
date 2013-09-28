module Subscriptions
  module TenantedModel
    extend ActiveSupport::Concern

    included do
      validates :tenant_id, presence: true, if: -> { Subscriptions.tenanting_enabled }
      validate :tenant_id_is_not_set, unless: -> { Subscriptions.tenanting_enabled }

      default_scope lambda {
        if Subscriptions.tenanting_enabled
          where(tenant_id: Subscriptions.current_tenant.call)
        end
      }
    end

    def tenant_id_is_not_set
      if tenant_id.present?
        errors.add(:tenant_id, "should not be set")
      end
    end

  end
end
