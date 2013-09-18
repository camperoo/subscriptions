class RemoveGatewayFeeFromPayments < ActiveRecord::Migration
  def change
    remove_column(:subscriptions_payments, :gateway_fee)
    remove_column(:subscriptions_payments, :gateway_fee_percentage)
  end
end
