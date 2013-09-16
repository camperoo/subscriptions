class CreateSubscriptionsPayments < ActiveRecord::Migration
  def change
    create_table :subscriptions_payments do |t|
      t.references :customer, index: true
      t.references :invoice, index: true
      t.references :card, index: true
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
