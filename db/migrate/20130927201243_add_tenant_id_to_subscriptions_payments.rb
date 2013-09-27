class AddTenantIdToSubscriptionsPayments < ActiveRecord::Migration
  def change
    add_column :subscriptions_payments, :tenant_id, :integer
  end
end
