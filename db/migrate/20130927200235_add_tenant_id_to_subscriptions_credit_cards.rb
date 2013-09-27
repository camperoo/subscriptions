class AddTenantIdToSubscriptionsCreditCards < ActiveRecord::Migration
  def change
    add_column :subscriptions_credit_cards, :tenant_id, :integer
  end
end
