class AddRetriesAndAmountToInvoice < ActiveRecord::Migration
  def change
    add_column :subscriptions_invoices, :retries, :integer
    add_column :subscriptions_invoices, :amount, :decimal
  end
end
