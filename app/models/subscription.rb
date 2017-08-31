class Subscription < ApplicationRecord
	belongs_to :user
	belongs_to :buyable, polymorphic: true

	scope :cart_open, -> {where(payment_id: nil)}
end
