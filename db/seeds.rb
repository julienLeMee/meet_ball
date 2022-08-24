require 'faker'

puts "Deleting all the models..."
Player.destroy_all
Game.destroy_all
User.destroy_all
Playground.destroy_all
puts "All the data deleted"
puts '--------------------------------'

puts "Creating the main user..."
main_user = User.create(username: "meetball", email: "a@a.a", password: "meetball")
puts "Main user #{main_user.username} created"

puts '--------------------------------'

puts "Creating games for the main user..."

3.times do
  game = Game.new(
    start_date: Faker::Date.between(from: '2022-07-23', to: '2022-09-25'),
    end_date: Faker::Date.between(from: '2022-09-26', to: '2022-10-12'),
    game_mode: rand(0..1),
    team_size: rand(0..2)
  )

  game.user = main_user

  playground = Playground.create(
    name: "The #{Faker::Sports::Basketball.team} Arena",
    address: Faker::Address.street_address,
    description: Faker::JapaneseMedia::OnePiece.quote
  )

  game.playground = playground
  game.save!

end

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
  puts '--------------------------------'

  puts "Successfully created #{playground.name} at #{playground.address} with #{playground.description}"

  puts '--------------------------------'

  games = []

  3.times do
    game = Game.new(
      start_date: Faker::Date.between(from: '2022-07-23', to: '2022-09-25'),
      end_date: Faker::Date.between(from: '2022-09-26', to: '2022-10-12'),
      game_mode: rand(0..1),
      team_size: rand(0..2)
    )

    game.user = user
    game.playground = playground
    game.save!

    games << game
  end

  games.each do |game|
    puts "Successfully created a #{game.game_mode.zero? ? 'Competitive' : 'Casual'} game starting at #{game.start_date} to #{game.end_date}"
  end

  puts '--------------------------------'

  players = []

  2..6.times do
    player = Player.new(
      confirmed_results: [true, false].sample,
      team: rand(0..1)
    )

    player.user = user
    player.game = games.sample
    player.save!

    players << player
  end

  players.each do |player|
    puts "Successfully created player in team: #{player.team.zero? ? 'Red' : 'Blue'}. The player has #{player.confirmed_results ? 'Confirmed' : 'Not confirmed'} game results."
    puts "Attributed to game starting #{player.game.start_date}. Same player is user #{player.user.username}."

    puts '--------------------------------'
  end

end

puts '--------------------------------'

puts "Seed completed with success"

puts '--------------------------------'
