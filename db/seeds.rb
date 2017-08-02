Admin.create(email: 'efej@admin.com', password: 'efej@@147')

lot1 = Lot.new do |lot|
  lot.name = "Primeiro lote"
  lot.number = 1
  lot.limit = 150
  lot.start_date = DateTime.new(2017, 8, 2, 22, 0, 0 , '-3')
  lot.end_date = DateTime.new(2017, 8, 3, 12, 0, 0 , '-3')
  lot.value_federated = 360
  lot.value_not_federated = 360
  lot.value_federated_nohost = 220
  lot.value_not_federated_nohost = 220
  lot.nohost_active = true
end
lot1.save!
