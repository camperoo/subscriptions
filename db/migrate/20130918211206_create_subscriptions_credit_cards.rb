class CreateSubscriptionsCreditCards < ActiveRecord::Migration
  def change
    create_table :subscriptions_credit_cards do |t|
      t.references :customer, index: true
      t.string :customer_profile_id
      t.string :customer_payment_profile_id

      t.timestamps
    end
  end
end
