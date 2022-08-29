require 'faker'
require 'open-uri'
require "uri"
require "net/http"

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

playgrounds_without_images = []
images_url = [
  "https://res.cloudinary.com/meetball/image/upload/v1661453647/Orlando_Magic.jpg",
  "https://res.cloudinary.com/meetball/image/upload/v1661453647/Houston_Rockets.png",
  "https://res.cloudinary.com/meetball/image/upload/v1661453647/Toronto_Raptors.webp",
  "https://res.cloudinary.com/meetball/image/upload/v1661453647/San_Antonio_Spurs.jpg",
  "https://res.cloudinary.com/meetball/image/upload/v1661453646/Cleveland_Cavaliers.jpg",
  "https://res.cloudinary.com/meetball/image/upload/v1661453646/Chicago_Bulls.webp",
  "https://res.cloudinary.com/meetball/image/upload/v1661453646/Boston_Celtics.jpg",
  "https://res.cloudinary.com/meetball/image/upload/v1661453646/LA_Clippers.jpg",
  "https://res.cloudinary.com/meetball/image/upload/v1661453646/Denver_Nuggets.webp"
]

puts "Creating users..."

3.times do
  user = User.create(
    username: Faker::Internet.username(specifier: 10),
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )

  game = Game.new(
    start_date: Faker::Time.between(from: DateTime.now - 2, to: DateTime.now - 1, format: :default),
    end_date: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default),
    game_mode: rand(0..1),
    team_size: rand(0..2)
  )

  enum = game.team_size.to_i
  number_of_players = enum * 2

  puts "Created game. Team size enum is : #{enum}. Number of players needed is #{number_of_players}."

  number_of_players.times do
    player = Player.new(
      confirmed_results: [true, false].sample,
      team: rand(0..1)
    )

    player.user = user
    player.game = game
    player.save!

  end

  start_date = game.start_date

  game.end_date = start_date + 1.hour

  game.user = main_user

  playground = Playground.create(
    name: "The #{Faker::Sports::Basketball.team} Arena",
    address: Faker::Address.street_address,
    description: Faker::JapaneseMedia::OnePiece.quote
  )

  playgrounds_without_images << playground

  game.playground = playground
  game.save!

end

# playgrounds_api_url = 'https://storage.googleapis.com/dx-montreal/resources/2dac229f-6089-4cb7-ab0b-eadc6a147d5d/terrain_sport_ext.json'
# playgrounds_api_serialized = URI.open(playgrounds_api_url).read
# playgrounds_api = JSON.parse(playgrounds_api_serialized)

# playgrounds_api["features"].each do |record|
#   if record["properties"]["NOM"].include?("Basketball")
#     Playground.create(
#       name:
#     )
#   end
# end

google_key = "AIzaSyAJmqLvSNaQn_bhVPmN_gR82I8s5TyN8r0"

def read_and_parse_url(url)
  playgrounds_api_serialized = URI.open(url).read
  JSON.parse(playgrounds_api_serialized)
end

def build_playground(json)
  json["results"].each do |result|
    if result["photos"]
      playground = Playground.create(
        name: result["name"],
        address: result["formatted_address"]
      )
      puts "Playground #{playground.name} successfully created"

      key = "AIzaSyAJmqLvSNaQn_bhVPmN_gR82I8s5TyN8r0"

      photo_reference = result["photos"][0]["photo_reference"]
      photo_url = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=1000&photo_reference=#{photo_reference}&key=#{key}"

      playground_image = URI.open(photo_url)
      playground.photo.attach(io: playground_image, filename: "#{playground['name']}.png", content_type: "image/png")
      playground.save!
      puts "Image given to #{playground.name}"
    end
  end
end

def create_playgrounds_from_url(url)
  json = read_and_parse_url(url)
  build_playground(json)
  return json["next_page_token"]
end

playgrounds_api_url = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=terrain%20de%20basketball%20montreal&key=#{google_key}"
next_token = create_playgrounds_from_url(playgrounds_api_url)

playgrounds_api_url2 = "https://maps.googleapis.com/maps/api/place/textsearch/json?pagetoken=#{next_token}&query=terrain%20de%20basketball%20montreal&key=#{google_key}"
next_token = create_playgrounds_from_url(playgrounds_api_url2)

playgrounds_api_url3 = "https://maps.googleapis.com/maps/api/place/textsearch/json?pagetoken=#{next_token}&query=terrain%30de%20basketball%20montreal&key=#{google_key}"
next_token = create_playgrounds_from_url(playgrounds_api_url3)


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

  playgrounds_without_images << playground
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

  games.each do |game|

    enum = game.team_size.to_i
    number_of_players = enum * 2

    puts "inside game. Team size enum is : #{enum}. Entering number_of_players.times with #{number_of_players} number of players."

    (enum - 1).times do
      player = Player.new(
        confirmed_results: [true, false].sample,
        team: 1
      )

      player.user = user
      player.game = game
      player.save!

      players << player

      puts "player saved!"

    end

    (enum - rand(0..1)).times do
      player = Player.new(
        confirmed_results: [true, false].sample,
        team: 0
      )

      player.user = user
      player.game = game
      player.save!

      players << player

      puts "player saved!"

    end

  end

  puts "games.each do. done."

  players.each do |player|
    puts "Successfully created player in team: #{player.team == 0 ? 'Red' : 'Blue'}. The player has #{player.confirmed_results ? 'Confirmed' : 'Not confirmed'} game results."
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

playgrounds_without_images.each do |playground|
  puts "------------------------------------"
  playground_image = URI.open(images_url.sample)
  playground.photo.attach(io: playground_image, filename: "image.png", content_type: "image/png")
  playground.save!
  puts "image given to playground"
end

puts '--------------------------------'

puts "Seed completed with success"

puts '--------------------------------'
