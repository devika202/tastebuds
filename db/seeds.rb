# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin = User.create(
    firstname:'Taste Buds',
    lastname:'Admin',
    username: 'admin',
    password: 'administrator',
    password_confirmation:'administrator',
    address:'Kerala,India',
    phone:'9633826969',
    email:'tastebudsadmin@gmail.com',
    confirmed_at: Time.now,
    admin: true
  )
admin = User.create(
  firstname:'Taste Buds',
  lastname:'Admin',
  username: 'admin@1',
  password: 'administrator',
  password_confirmation:'administrator',
  address:'Kerala,India',
  phone:'9633826969',
  email:'tastebudsadmin1@gmail.com',
  confirmed_at: Time.now,
  admin: true
)
admin = User.create(
  firstname:'Taste Buds',
  lastname:'Admin',
  username: 'admin@2',
  password: 'administrator',
  password_confirmation:'administrator',
  address:'Kerala,India',
  phone:'9633826969',
  email:'tastebudsadmin2@gmail.com',
  confirmed_at: Time.now,
  admin: true
)
admin = User.create(
  firstname:'Taste Buds',
  lastname:'Admin',
  username: 'admin@3',
  password: 'administrator',
  password_confirmation:'administrator',
  address:'Kerala,India',
  phone:'9633826969',
  email:'tastebudsadmin3@gmail.com',
  confirmed_at: Time.now,
  admin: true
)

  puts "Admin user created: #{admin.username} / #{admin.password}"
