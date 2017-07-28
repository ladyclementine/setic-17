Admin.create(email: 'admin@admin.com', password: '12345678')

lot1 = Lot.new do |lot|
  lot.name = "Primeiro lote"
  lot.number = 1
  lot.limit = 500
  lot.start_date = DateTime.new(2017, 7, 5, 01, 0, 0 , '-3')
  lot.end_date = DateTime.new(2017, 9, 20, 23, 59, 59 , '-3')
  lot.value_federated = 340
  lot.value_not_federated = 360
end
lot1.save!
