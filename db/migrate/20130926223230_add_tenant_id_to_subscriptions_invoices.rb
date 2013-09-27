class AddTenantIdToSubscriptionsInvoices < ActiveRecord::Migration
  def change
    add_column :subscriptions_invoices, :tenant_id, :integer
  end
end
