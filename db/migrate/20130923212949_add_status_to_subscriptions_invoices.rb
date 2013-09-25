class AddStatusToSubscriptionsInvoices < ActiveRecord::Migration
  def change
    add_column :subscriptions_invoices, :status, :string, default: "pending"
  end
end
