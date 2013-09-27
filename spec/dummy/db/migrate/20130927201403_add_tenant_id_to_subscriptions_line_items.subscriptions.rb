# This migration comes from subscriptions (originally 20130927201253)
class AddTenantIdToSubscriptionsLineItems < ActiveRecord::Migration
  def change
    add_column :subscriptions_line_items, :tenant_id, :integer
  end
end
