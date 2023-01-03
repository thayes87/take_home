class CustomerSubscription < ApplicationRecord
  belongs_to :customer
  belongs_to :subscription

  validates :cusomter_id, presence: true
  validates :subscription_id, presence: true
end