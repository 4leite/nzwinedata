# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
default_pwd = ENV['RAILS_DEFAULT_PWD']

def sale_with_notes(site, date, notes)
  a_daily_sale = DailySale.find_or_initialize_by(site: site, sale_date: date)
  a_daily_sale.update_attributes(customers: Random.rand(1...20), units: Random.rand(1...200), sales_gross: Random.rand(1...9000), notes: notes )
  a_daily_sale.save
end

site1 = Site.find_or_create_by(name: "NZ Wine")
site2 = Site.find_or_create_by(name: "A Winery")
site3 = Site.find_or_create_by(name: "Winery with a really long name")

user1 = User.create(site: site1, roles: [ "dev", "global_admin" ], email: "jon@4pi.nz", password: default_pwd, password_confirmation: default_pwd)
user2 = User.create(site: site1, roles: "global_admin", email: "jaketipler@gmail.com", password: default_pwd, password_confirmation: default_pwd)
user3 = User.create(site: site2, roles: "site_admin", email: "manager@4pi.nz", password: default_pwd, password_confirmation: default_pwd)
user4 = User.create(site: site2, roles: "miner", email: "miner@4pi.nz", password: default_pwd, password_confirmation: default_pwd)

(Date.current-2.months..Date.current).each do |d|
  a_daily_sale = DailySale.find_or_initialize_by(site_id: site2.id, sale_date: d)
  a_daily_sale.update_attributes(customers: Random.rand(1...20), units: Random.rand(1...200), sales_gross: Random.rand(1...9000))
  a_daily_sale.save
end

sale_with_notes( site3, Date.current-4.days, "a short note" )
sale_with_notes( site3, Date.current-3.days, "a slightly longer note about the sale that someone might type on one line" )
sale_with_notes( site3, Date.current-2.days, %(a really long note about cheese: 
                             I love cheese, especially brie port-salut. Pecorino cheddar pecorino squirty cheese hard cheese emmental cow boursin. Goat red leicester jarlsberg squirty cheese cheeseburger macaroni cheese say cheese roquefort. Mozzarella caerphilly jarlsberg bocconcini pecorino roquefort pecorino red leicester. When the cheese comes out everybody's happy chalk and cheese boursin when the cheese comes out everybody's happy feta mozzarella stilton cheese slices. Stilton cream cheese cheddar rubber cheese cheeseburger cow babybel cheese on toast. Paneer cauliflower cheese rubber cheese pepper jack st. agur blue cheese feta cream cheese manchego. Squirty cheese taleggio roquefort croque monsieur fromage queso ricotta monterey jack. Feta who moved my cheese cheese and biscuits blue castello cheeseburger mascarpone cheese and wine emmental. Mascarpone cottage cheese everyone loves smelly cheese croque monsieur stilton cheesy grin dolcelatte. Edam mascarpone babybel cheese triangles melted cheese bocconcini stinking bishop.') )

sale_with_notes( site3, Date.current-1.days, %('a really long list: \n
                             I love cheese, especially brie port-salut. \n
                             Pecorino \n
                             Cheddar \n
                             Pecorino squirty cheese \n
                             Hard cheese \n
                             Emmental \n
Cow boursin) )

