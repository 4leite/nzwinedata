# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
default_pwd = ENV['RAILS_DEFAULT_PWD']

site1 = Site.find_or_create_by(name: "NZ Wine")
site2 = Site.find_or_create_by(name: "A Winery")

user1 = User.create(site: site1, roles: [ "dev", "global_admin" ], email: "jon@4pi.nz", password: default_pwd, password_confirmation: default_pwd)

user2 = User.create(site: site1, roles: "global_admin", email: "jaketipler@gmail.com", password: default_pwd, password_confirmation: default_pwd)

user3 = User.create(site: site2, roles: "site_admin", email: "manager@4pi.nz", password: default_pwd, password_confirmation: default_pwd)

user4 = User.create(site: site2, roles: "miner", email: "miner@4pi.nz", password: default_pwd, password_confirmation: default_pwd)



