# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

['Troop 1564', 'Troop 1804'].each do |name|
  Unit.find_or_create_by(name: name)
end

# troop = Troop.first
# %w(Swimming Hiking\ Hoh\ River Capture\ the\ flag).each do |a|
#   troop.activities.create(name: a)
# end

User.create(email: 'carson.cole@protonmail.com', password: 'SChiLanC67', is_app_admin: true)
