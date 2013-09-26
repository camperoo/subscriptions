# This migration comes from subscriptions (originally 20130903231135)
class CreateSubscriptionsInvoices < ActiveRecord::Migration
  def change
    create_table :subscriptions_invoices do |t|
      t.date :invoice_start_date
      t.date :invoice_end_date
      t.references :customer, index: true

      t.timestamps
    end
  end
end
