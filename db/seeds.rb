# fake users
User.where(username: 'Holden').first_or_create
User.where(username: 'Woody').first_or_create
User.where(username: 'Roxy').first_or_create
User.where(username: 'Jeter').first_or_create
