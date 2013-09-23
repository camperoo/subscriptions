class ChangeAmountToDecimalInSubscriptionPayments < ActiveRecord::Migration
  def change
    remove_column(:subscriptions_payments, :amount)
    add_column(:subscriptions_payments, :amount, :decimal)
  end
end
