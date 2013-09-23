# This migration comes from subscriptions (originally 20130918203832)
class RemoveGatewayFeeFromPayments < ActiveRecord::Migration
  def change
    remove_column(:subscriptions_payments, :gateway_fee)
    remove_column(:subscriptions_payments, :gateway_fee_percentage)
  end
end
