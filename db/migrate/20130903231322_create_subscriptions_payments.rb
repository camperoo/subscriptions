class CreateSubscriptionsPayments < ActiveRecord::Migration
  def change
    create_table :subscriptions_payments do |t|
      t.references :customer, index: true
      t.references :invoice, index: true
      t.references :card, index: true
      t.decimal :amount
      t.decimal :fee
      t.date :date
      t.string :status
      t.string :description

      t.timestamps
    end
  end
end
