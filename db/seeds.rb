# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

#csv_text = File.read(Rails.root.join('lib', 'seeds', 'friends.csv'))
#csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
#csv.each do |row|
#  t = Friend.new
#  t.first_name = row['first_name']
#  t.last_name = row['last_name']
#  t.email = row['email']
#  t.phone = row['phone']
#  t.twitter = row['twitter']
#  t.save
#  puts "#{t.first_name}, #{t.last_name} saved"
#end


CSV.foreach(Rails.root.join('lib/seeds/friends.csv'), headers: true, encoding: 'ISO-8859-1') do |row|
  Friend.create( {
    first_name: row["first_name"],
    last_name: row["last_name"],
    email: row["email"],
    phone: row["phone"],
    twitter: row["twitter"]
  } )
  puts "#{row["first_name"]}, #{row["last_name"]} saved"
end

puts "There are now #{Friend.count} additional rows in the friends table"
