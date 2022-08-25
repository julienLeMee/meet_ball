require 'faker'

puts "Deleting all the models..."
Result.destroy_all
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
    start_date: Faker::Time.between(from: DateTime.now - 2, to: DateTime.now - 1, format: :default),
    end_date: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default),
    game_mode: rand(0..1),
    team_size: rand(0..2)
  )

  start_date = game.start_date

  game.end_date = start_date + 1.hour

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
      start_date: Faker::Time.between(from: DateTime.now - 2, to: DateTime.now - 1, format: :default),
      end_date: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default),
      game_mode: rand(0..1),
      team_size: rand(0..2)
    )

    start_date = game.start_date

    game.end_date = start_date + 1.hour

    game.user = user
    game.playground = playground
    game.save!

    games << game
  end

  games.each do |game|
    puts "Successfully created a #{game.game_mode == 0 ? 'Competitive' : 'Casual'} game starting at #{game.start_date} to #{game.end_date}"
  end

  puts '--------------------------------'

  players = []
  players_who_confirmed = []

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

    if player.confirmed_results?
      players_who_confirmed << player
    end
  end

  if (players.length / 2).to_f > players_who_confirmed.length
    status = 0
  else
    status = 1
  end

  result = Result.new(
    red_score: [20..50].sample,
    blue_score: [20..50].sample,
    status: status
  )

  result.game = games.sample
  result.save!

  puts "Successfully created results for game: #{result.game}."
  puts "#{players_who_confirmed.length} players confirmed the game results. Results are #{result.status == 0 ? "Confirmed" : "Not confirmed"}."
end

puts '--------------------------------'

puts "Seed completed with success"

puts '--------------------------------'
