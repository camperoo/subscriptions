class AddTenantIdToSubscriptionsPlans < ActiveRecord::Migration
  def change
    add_column :subscriptions_plans, :tenant_id, :integer
  end
end
