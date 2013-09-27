# This migration comes from subscriptions (originally 20130927200224)
class AddTenantIdToSubscriptionsEvents < ActiveRecord::Migration
  def change
    add_column :subscriptions_events, :tenant_id, :integer
  end
end
