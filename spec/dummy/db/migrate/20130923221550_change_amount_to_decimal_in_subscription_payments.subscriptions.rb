# This migration comes from subscriptions (originally 20130923201445)
class ChangeAmountToDecimalInSubscriptionPayments < ActiveRecord::Migration
  def change
    remove_column(:subscriptions_payments, :amount)
    add_column(:subscriptions_payments, :amount, :decimal)
  end
end
