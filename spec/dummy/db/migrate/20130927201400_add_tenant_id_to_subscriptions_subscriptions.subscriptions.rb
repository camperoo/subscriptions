# This migration comes from subscriptions (originally 20130927201226)
class AddTenantIdToSubscriptionsSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions_subscriptions, :tenant_id, :integer
  end
end
