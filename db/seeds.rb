Admin.create(email: 'efej@admin.com', password: 'efej@@147')

User.create(email: 'user@user.com', password: '12345678')
Event.create(facilitator: 'fulano', limit: 4, name: 'Título da palestra', price: 12.0)
Shirt.create(size: 'p', price: 25, limit: 10)
Shirt.create(size: 'm', price: 25, limit: 10)
Subscription.create(user_id: 1, event_id: 1)
