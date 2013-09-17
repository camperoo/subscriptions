class CreateSubscriptionsEvents < ActiveRecord::Migration
  def change
    create_table :subscriptions_events do |t|
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
