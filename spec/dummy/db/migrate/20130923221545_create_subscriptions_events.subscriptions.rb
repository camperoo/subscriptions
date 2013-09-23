# This migration comes from subscriptions (originally 20130917220216)
class CreateSubscriptionsEvents < ActiveRecord::Migration
  def change
    create_table :subscriptions_events do |t|
      t.references :payment
      t.string :user
      t.string :action
      t.string :amount
      t.string :data
      t.string :type
      t.string :source

      t.timestamps
    end
  end
end
