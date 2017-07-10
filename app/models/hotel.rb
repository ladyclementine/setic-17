class Hotel < ApplicationRecord
  has_many :rooms

  def restant_capacity
    total_restant = 0
    self.rooms.each do |r|
      total_restant += (r.capacity.to_i - r.users.count.to_i)
    end
    total_restant
  end

  def capacity
    capacity = 0
    rooms.all.each do |room|
      capacity += room.capacity
    end
    capacity
  end

end
