# This migration comes from subscriptions (originally 20130926223230)
class AddTenantIdToSubscriptionsInvoices < ActiveRecord::Migration
  def change
    add_column :subscriptions_invoices, :tenant_id, :integer
  end
end
