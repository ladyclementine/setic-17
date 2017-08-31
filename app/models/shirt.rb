class Shirt < ApplicationRecord
	has_many :subscriptions, as: :buyable
	has_many :events, through: :subscriptions 
end
