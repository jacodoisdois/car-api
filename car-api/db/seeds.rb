# User.create! email: 'teste123@gmail.com', password: 'serelepe', name: 'Pedro Silva', nickname: 'joaosilva123'

# Customer.create! name: 'João Santos da Silva', email: 'joaodasilva@gmail.com',
#                  social_security_number: 12_348_576_910, birth_date: '1999-03-03', phone_attributes: { country_code: '55', local_code: '11', number: '954389280' }, addresses_attributes: [{
#                    address: 'Rua Mario santos', number: 34, district: 'Vila Rio', number: 54, city: 'Guarulhos', state: 'SP', zip_code: '06043050', main_address: false
#                  }]
c = Customer.create! name: 'Mario Santos da Silva', email: 'mariosantos@gmail.com',
                     social_security_number: 12_348_576_911, birth_date: '1999-03-03', phone_attributes: { country_code: '55', local_code: '11', number: '954389280' }, addresses_attributes: [{
                       address: 'Rua Mario santos', number: 34, district: 'Vila Rio', number: 54, city: 'Guarulhos', state: 'SP', zip_code: '06043050', main_address: false
                     }]

# c = Customer.find(980_190_963)

order = Order.new(customer: c)

order.order_products.build([{
                             product: Product.new(title: 'Grease G205', description: 'Grease for mechanical keyboard', price: 1.8,
                                                  quantity: 99), quantity: 9
                           },
                            {
                              product: Product.new(title: 'Grease G206', description: 'Grease for mechanical keyboard', price: 1,
                                                   quantity: 99), quantity: 10
                            }])
order.save
