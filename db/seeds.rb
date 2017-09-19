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



Event.create(facilitator: 'fulano2', limit: 4, name: 'Gti empreender', price: 30.0, event_type_id: 2)
Schedule.create(start_time: DateTime.new(2017,9,15,9,00,-3), end_time: DateTime.new(2017,9,15,12,00,-3), event_id: 4)

Event.create(facilitator: 'fulano2', limit: 4, name: 'SONU empreender', price: 30.0, event_type_id: 1)
Schedule.create(start_time: DateTime.new(2017,9,17,9,00,-3), end_time: DateTime.new(2017,9,17,12,00,-3), event_id: 6)
#Subscription.create(user_id: 1, event_id: 1)
#Subscription.create(user_id: 1, event_id: 2)

EventType.create(name: 'Visita Técnica')
EventType.create(name: 'Workshop')



Event.create(facilitator: 'fulano2', limit: 4, name: 'Workshop TESTE', price: 30.0, event_type_id: 4)
Schedule.create(start_time: DateTime.new(2017,9,18,9,00,-3), end_time: DateTime.new(2017,9,18,12,00,-3), event_id: 7)


Event.create(facilitator: 'fulano2', limit: 4, name: 'Workshop TESTE', price: 30.0, event_type_id: 4)
Schedule.create(start_time: DateTime.new(2017,9,18,12,00,-3), end_time: DateTime.new(2017,9,18,15,00,-3), event_id: 8)
#Subscription.create(user_id: 1, event_id: 1)

