class CreateSubscriptionsLineItems < ActiveRecord::Migration
  def change
    create_table :subscriptions_line_items do |t|
      t.string :description
      t.decimal :amount
      t.date :date_added
      t.references :invoice, index: true

      t.timestamps
    end
  end
end
