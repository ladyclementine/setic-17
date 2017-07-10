for i in 0..25
  c = rand(3..5)
  rooms = Room.new do |room|
    room.name = "quarto #{i}"
    room.capacity = c
    room.number = i + 100
    room.extra_info = "#{c-1} camas + 1 rede"
    room.hotel_id =  1
  end
  
  if rooms.save!
    Rails.logger.info "#{rooms.name} foi adicionado"
  else
    Rails.logger.info "Não foi possível adicionar #{rooms.name}. Erros:\n\t #{rooms.errors.full_messages}"
  end
end


for i in 0..25
  c = rand(3..5)
  rooms = Room.new do |room|
    room.name = "quarto #{i}"
    room.capacity = c
    room.number = i + 126
    room.extra_info = "#{c-1} camas + 1 rede"
    room.hotel_id =  2
  end
  
  if rooms.save!
    Rails.logger.info "#{rooms.name} foi adicionado"
  else
    Rails.logger.info "Não foi possível adicionar #{rooms.name}. Erros:\n\t #{rooms.errors.full_messages}"
  end
end
