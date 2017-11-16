# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
roles = Role.create([{ name: 'Manager'}, { name: 'Buyer'}])

VendorCategory.create([{ name: 'default'},{ name: 'Baby'},{ name: 'Beauty'},{ name: 'Clothing'},{ name: 'Food'}])
SkynetIdType.create([{ id: 0, name: 'ASIN'},{ id: 1, name: 'UPC'},{ id: 2, name: 'ISBN'},{ id: 3, name: 'EAN'}])
SkynetStatus.create([{ id: 0, name: 'InQueue'},{ id: 1, name: 'Processing'},{ id: 2, name: 'Nothing'},{ id: 3, name: 'Completed'},{ id: 4, name: 'Failed'},{ id: 5, name: 'Cancelled'},{ id: 6, name: 'AskCancel'}])


