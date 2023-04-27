# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin = User.create(
    firstname:'Devika',
    lastname:'S',
    username: 'admin',
    password: 'administrator',
    password_confirmation:'administrator',
    address:'Kollam,kerala,India',
    phone:'9633',
    email:'devikaskrishnan1118@gmail.com',
    admin: true
  )
  
  puts "Admin user created: #{admin.username} / #{admin.password}"