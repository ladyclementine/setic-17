event = Event.find(18)

User.pays.each do |user|
  event.add user
end
