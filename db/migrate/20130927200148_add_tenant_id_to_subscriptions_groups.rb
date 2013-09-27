class AddTenantIdToSubscriptionsGroups < ActiveRecord::Migration
  def change
    add_column :subscriptions_groups, :tenant_id, :integer
  end
end
