class Subscription < ApplicationRecord
	belongs_to :user
	belongs_to :event
	belongs_to :shirt, class_name: 'User', foreign_key: "event_id"
	belongs_to :all_itens, class_name: 'User', foreign_key: "event_id"
	validates_uniqueness_of :user_id, :scope => :event, message: "ID %{value} já foi cadastrado neste evento."
end
