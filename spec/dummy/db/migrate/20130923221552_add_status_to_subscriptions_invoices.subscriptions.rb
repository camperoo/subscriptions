# This migration comes from subscriptions (originally 20130923212949)
class AddStatusToSubscriptionsInvoices < ActiveRecord::Migration
  def change
    add_column :subscriptions_invoices, :status, :string
  end
end
