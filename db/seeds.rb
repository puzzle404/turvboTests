# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "Cleaning database..."
User.destroy_all
Restaurant.destroy_all

puts "Seeds eliminados"
puts "......................"
puts "Creating users..."
manu = User.create!(email: "cmanuferrer@gmail.com", password: 123456)
gonza =  User.create!(email: "gonza@gmail.com", password: 123456 )

puts "Finished users!"
puts "Creating restaurants..."
dishoom = {name: "Dishoom", address: "7 Boundary St, London E2 7JE", rating: 5, user: manu}
pizza_east =  {name: "Pizza East", address: "56A Shoreditch High St, London E1 6PQ", rating: 4, user: gonza}

[dishoom, pizza_east].each do |attributes|
  restaurant = Restaurant.create!(attributes)
  puts "Created #{restaurant.name}"
end
puts "Finished restaurants!"
