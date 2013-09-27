class AddTenantIdToSubscriptionsLineItems < ActiveRecord::Migration
  def change
    add_column :subscriptions_line_items, :tenant_id, :integer
  end
end
