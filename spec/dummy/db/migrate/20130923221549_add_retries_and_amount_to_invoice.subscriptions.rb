# This migration comes from subscriptions (originally 20130923153954)
class AddRetriesAndAmountToInvoice < ActiveRecord::Migration
  def change
    add_column :subscriptions_invoices, :retries, :integer, default: 0
    add_column :subscriptions_invoices, :amount, :decimal
  end
end
