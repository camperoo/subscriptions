# This migration comes from subscriptions (originally 20130903231322)
class CreateSubscriptionsPayments < ActiveRecord::Migration
  def change
    create_table :subscriptions_payments do |t|
      t.references :customer, index: true
      t.references :invoice, index: true
      t.integer :amount
      t.integer :gateway_fee
      t.decimal :gateway_fee_percentage
      t.integer :merchant_fee
      t.decimal :merchant_fee_percentage
      t.date :date
      t.string :status
      t.string :description

      t.timestamps
    end
  end
end
