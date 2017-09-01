Admin.create(email: 'admin@admin.com', password: '12345678')

User.create(email: 'user@user.com', password: '12345678')

EventType.create(name: 'Palestra')
EventType.create(name: 'Curso')
Event.create(facilitator: 'fulano', limit: 4, name: 'Título da palestra', price: 12.0, event_type_id: 1)
Event.create(facilitator: 'fulano', limit: 4, name: 'Título da palestra 2', price: 12.0, event_type_id: 2)


Event.create(limit: 10, name: 'Camisa M', price: 12.0, is_shirt: true)

Schedule.create(start_time: DateTime.new(2017,9,5,8,30), end_time: DateTime.new(2017,9,5,9,30), event_id:1)
Schedule.create(start_time: DateTime.new(2017,9,5,8,30), end_time: DateTime.new(2017,9,5,9,30), event_id:1)
Schedule.create(start_time: DateTime.new(2017,9,6,10,00), end_time: DateTime.new(2017,9,6,12,00), event_id: 2)


#Subscription.create(user_id: 1, event_id: 1)
#Subscription.create(user_id: 1, event_id: 2)




