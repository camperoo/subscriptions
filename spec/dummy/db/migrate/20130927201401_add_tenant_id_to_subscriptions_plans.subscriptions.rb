# This migration comes from subscriptions (originally 20130927201235)
class AddTenantIdToSubscriptionsPlans < ActiveRecord::Migration
  def change
    add_column :subscriptions_plans, :tenant_id, :integer
  end
end
