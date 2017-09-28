class Subscription < ApplicationRecord
	belongs_to :user
	belongs_to :event
	validates_uniqueness_of :user_id, :scope => :event, message: "ID %{value} já foi cadastrado neste evento."
end
