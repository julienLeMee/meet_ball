require 'faker'

puts "Deleting all the models..."
User.destroy_all
Playground.destroy_all
puts "All the data deleted"
puts '--------------------------------'


puts "Creating the main user..."
main_user = User.create(username: "meetball", email: "a@a.a", password: "meetball")
puts "Main user #{main_user.username} created"

puts '--------------------------------'

puts "Creating users..."

10.times do
  user = User.create(
    username: Faker::Internet.username(specifier: 10),
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )

  puts "Successfully created #{user.username} with #{user.email}"

  puts '--------------------------------'

  puts "Creating playgrounds..."

  playground = Playground.create(
    name: "The #{Faker::Sports::Basketball.team} Arena",
    address: Faker::Address.street_address,
    description: Faker::JapaneseMedia::OnePiece.quote
  )

  puts "Successfully created #{playground.name} at #{playground.address} with #{playground.description}"
end
