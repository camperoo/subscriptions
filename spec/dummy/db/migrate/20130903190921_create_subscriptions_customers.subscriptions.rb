# This migration comes from subscriptions (originally 20130903185531)
class CreateSubscriptionsCustomers < ActiveRecord::Migration
  def change
    create_table :subscriptions_customers do |t|
      t.string :email
      t.string :description
      t.decimal :account_balance
      t.string :assigned_id

      t.timestamps
    end
  end
end
