User.create!(email: 'teste@teste.com', name: 'Teste', password: '123456')
Product.sync_products
