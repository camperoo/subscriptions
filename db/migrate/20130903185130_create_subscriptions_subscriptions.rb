class CreateSubscriptionsSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions_subscriptions do |t|
      t.date :start_date
      t.references :plan, index: true
      t.references :customer, index: true

      t.timestamps
    end
  end
end
