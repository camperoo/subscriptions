class AddTenantIdToSubscriptionsSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions_subscriptions, :tenant_id, :integer
  end
end
