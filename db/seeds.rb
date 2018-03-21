puts "Creating Users"
User.where(username: 'Holden').first_or_create
User.where(username: 'Woody').first_or_create
user1 = User.where(username: 'Roxy').first_or_create
user2 = User.where(username: 'Jeter').first_or_create

puts "Creating Promotions"
Promotion.where(start_date: '2018-04-01', end_date: '2018-04-15', discount: 2000,  user_message: 'You saved $20', internal_message: 'fake internal message 20', code: '20-discount').first_or_create
Promotion.where(start_date: '2018-04-15', end_date: '2018-04-25', discount: 3000,  user_message: 'You saved $30', internal_message: 'fake internal message 30', code: '30-discount').first_or_create
user1.promotions.where(start_date: '2018-04-01', end_date: '2018-04-15', discount: 2000,  user_message: 'You saved $20 for your loyalty', internal_message: 'fake internal message 20 assigned', code: '20-assigned', assigned: true).first_or_create
user2.promotions.where(start_date: '2018-04-15', end_date: '2018-04-25', discount: 3000,  user_message: 'You saved $30 for your loyalty', internal_message: 'fake internal message 30 assigned', code: '30-assigned', assigned: true).first_or_create
