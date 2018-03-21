# fake users
User.where(username: 'Holden').first_or_create
User.where(username: 'Woody').first_or_create
User.where(username: 'Roxy').first_or_create
User.where(username: 'Jeter').first_or_create

# fake promotions
Promotion.where(start_date: '4/1/2018', end_date: '4/15/2018', discount: 2000,  user_message: 'You saved $20', internal_message: 'fake internal message 20', code: '20-discount').first_or_create
Promotion.where(start_date: '4/15/2018', end_date: '4/25/2018', discount: 3000,  user_message: 'You saved $30', internal_message: 'fake internal message 30', code: '30-discount').first_or_create
