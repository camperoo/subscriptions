# This migration comes from subscriptions (originally 20130927200148)
class AddTenantIdToSubscriptionsGroups < ActiveRecord::Migration
  def change
    add_column :subscriptions_groups, :tenant_id, :integer
  end
end
