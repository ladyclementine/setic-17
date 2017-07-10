#Reset id auto increment (rails console)
#ActiveRecord::Base.connection.reset_pk_sequence!('rooms')

@last = 1

#Jangadeiro Terreo; Total: 24 quartos (All ar)
for i in 1..19
  room = Room.new do |room|
    room.capacity = 3
    room.number = @last + 100
    room.extra_info = "3 Camas"
    room.hotel_id =  1
    room.air = true
    @last += 1
  end
  room.save
end

for i in 1..3
  room = Room.new do |room|
    room.capacity = 4
    room.number = @last + 100
    room.extra_info = "3 Camas + 1 Rede"
    room.hotel_id =  1
    room.air = true
    @last += 1
  end
  room.save
end


for i in 1..2
  room = Room.new do |room|
    room.capacity = 5
    room.number = @last + 100
    room.extra_info = "5 Camas"
    room.hotel_id =  1
    room.air = true
    @last += 1
  end
  room.save
end

#Jangadeiro Chalé; Total: 5 quartos  (All Ventilador)
for i in 1..2
  room = Room.new do |room|
    room.capacity = 3
    room.number = @last + 100
    room.extra_info = "3 Camas"
    room.hotel_id =  3
    room.air = false
    @last += 1
  end
  room.save
end

room = Room.new do |room|
  room.capacity = 5
  room.number = @last + 100
  room.extra_info = "4 Camas + 1 Rede"
  room.hotel_id =  3
  room.air = false
  @last += 1
end
room.save

for i in 1..2
  room = Room.new do |room|
    room.capacity = 5
    room.number = @last + 100
    room.extra_info = "5 Camas"
    room.hotel_id =  3
    room.air = false
    @last += 1
  end
  room.save
end

#Jangadeiro Superior; Total: 26 quartos (All ar)
for i in 1..22
  room = Room.new do |room|
    room.capacity = 4
    room.number = @last + 100
    room.extra_info = "3 Camas + 1 Rede"
    room.hotel_id =  2
    room.air = true
    @last += 1
  end
  room.save
end

for i in 1..4
  room = Room.new do |room|
    room.capacity = 6
    room.number = @last + 100
    room.extra_info = "5 Camas + 1 Rede"
    room.hotel_id =  2
    room.air = true
    @last += 1
  end
  room.save
end

#Donana Terreo; Total: 15 quartos (All ar)
for i in 1..12
  room = Room.new do |room|
    room.capacity = 4
    room.number = @last + 100
    room.extra_info = "3 Camas + 1 Rede"
    room.hotel_id =  4
    room.air = true
    @last += 1
  end
  room.save
end

room = Room.new do |room|
  room.capacity = 5
  room.number = @last + 100
  room.extra_info = "3 Camas + 2 Redes"
  room.hotel_id =  4
  room.air = true
  @last += 1
end
room.save

for i in 1..2
  room = Room.new do |room|
    room.capacity = 6
    room.number = @last + 100
    room.extra_info = "4 Camas + 2 Redes"
    room.hotel_id =  4
    room.air = true
    @last += 1
  end
  room.save
end

#Donana Superior; Total: 16 quartos (All ar)
for i in 1..13
  room = Room.new do |room|
    room.capacity = 4
    room.number = @last + 100
    room.extra_info = "3 Camas + 1 Rede"
    room.hotel_id =  5
    room.air = true
    @last += 1
  end
  room.save
end

for i in 1..2
  room = Room.new do |room|
    room.capacity = 5
    room.number = @last + 100
    room.extra_info = "3 Camas + 2 Redes"
    room.hotel_id =  5
    room.air = true
    @last += 1
  end
  room.save
end

room = Room.new do |room|
  room.capacity = 6
  room.number = @last + 100
  room.extra_info = "4 Camas + 2 Redes"
  room.hotel_id =  5
  room.air = true
  @last += 1
end
room.save
