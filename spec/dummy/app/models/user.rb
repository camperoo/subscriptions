class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #Should probably extract this out to "subscriptions" method that is 
  #automatically added through meta-data
  has_many :invoices, class_name: "Subscriptions::Invoice"
  has_many :payments, class_name: "Subscriptions::Payment"
  has_one :credit_card, class_name: "Subscriptions::CreditCard"

end
