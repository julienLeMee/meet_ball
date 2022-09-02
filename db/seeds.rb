require 'faker'
require 'open-uri'
require "uri"
require "net/http"

puts "Deleting all the models..."
Badge.destroy_all
UserBadge.destroy_all
Result.destroy_all
Player.destroy_all
Game.destroy_all
Playground.destroy_all
Chatroom.destroy_all
User.destroy_all
puts "All the data deleted"
puts '--------------------------------'

second_user = User.create(username: "Julien", email: "b@b.b", password: "meetball", rank: 2, rank_points: 2500, highest_rank: 2)

puts '--------------------------------'
puts "Main user #{second_user.username} created"
puts '--------------------------------'

lebron = User.create(username: "Lebron", email: "c@c.c", password: "meetball", rank: 2, rank_points: 2500, highest_rank: 2)
lebron_image = URI.open("https://res.cloudinary.com/meetball/image/upload/v1661799775/Avatars/Lebron_xyan6e.jpg")
lebron.photo.attach(io: lebron_image, filename: "#{lebron['username']}.png", content_type: "image/png")
lebron.save!

puts "Image given to #{lebron.username}"

chatroom = Chatroom.create(name: "general")

puts '--------------------------------'
puts "Chatroom #{chatroom.name} created"
puts '--------------------------------'

second_user_photo_url = "https://res.cloudinary.com/meetball/image/upload/v1661799776/Avatars/VC_mryw8j.jpg"

second_user_image = URI.open(second_user_photo_url)
second_user.photo.attach(io: second_user_image, filename: "#{second_user['username']}.png", content_type: "image/png")
second_user.save!
puts "Image given to #{second_user.email}"

Badge::BADGES.each do |badge|
  new_badge = Badge.new(
    name: badge
  )

  def attach_photo(new_badge, url)
    badge_image = URI.open(url)
    new_badge.photo.attach(io: badge_image, filename: "#{new_badge['name']}.png", content_type: "image/png")
    new_badge.save!
  end

  case new_badge.name

    when "faiplay"
      url = "https://res.cloudinary.com/meetball/image/upload/v1661868541/User%20Badges/Team_Player_pebdby.png"
      attach_photo(new_badge, url)

    when "rebounder"
      url = "https://res.cloudinary.com/meetball/image/upload/v1661868541/User%20Badges/Rebouder_iddwwf.png"
      attach_photo(new_badge, url)

    when "sharpshoter"
      url = "https://res.cloudinary.com/meetball/image/upload/v1661868542/User%20Badges/Sharpshooter_drwco1.png"
      attach_photo(new_badge, url)

    when "mvp"
      url = "https://res.cloudinary.com/meetball/image/upload/v1661868541/User%20Badges/Game_MVP_ovqzr7.png"
      attach_photo(new_badge, url)

    when "playmaker"
      url = "https://res.cloudinary.com/meetball/image/upload/v1661868541/User%20Badges/Playmaker_krgav6.png"
      attach_photo(new_badge, url)

    when "dribble god"
      url = "https://res.cloudinary.com/meetball/image/upload/v1661868541/User%20Badges/Dribble_God_npkfwm.png"
      attach_photo(new_badge, url)
    else

      puts ""
      puts "Could not give image to new badge."
      puts ""

  end

  puts ""
  puts "created new badge: #{new_badge.name}"
  puts ""
end


puts "Creating playgrounds..."

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

 avatar_url = [
  "https://res.cloudinary.com/meetball/image/upload/v1661799775/Avatars/AI_pub3zu.jpg",
  "https://res.cloudinary.com/meetball/image/upload/v1661799775/Avatars/Jordan_dqcfsp.png",
  "https://res.cloudinary.com/meetball/image/upload/v1661799775/Avatars/Curry_ona8v3.png",
  "https://res.cloudinary.com/meetball/image/upload/v1661799775/Avatars/Kobe_n9ovsn.jpg",
  "https://res.cloudinary.com/meetball/image/upload/v1661799776/Avatars/KG_hkopdc.jpg",
  "https://res.cloudinary.com/meetball/image/upload/v1661799776/Avatars/Tatum_lvqoh2.jpg",
  "https://res.cloudinary.com/meetball/image/upload/v1661799775/Avatars/Curry_ona8v3.png",
  "https://res.cloudinary.com/meetball/image/upload/v1661799775/Avatars/Jordan_dqcfsp.png",
  "https://res.cloudinary.com/meetball/image/upload/v1661799775/Avatars/Durant_cgbjbj.jpg"
]


10.times do
  avatar_url << "https://i.pravatar.cc"
end

avatar_url.each do |url|

  rank_value = rand(0..5)

  user = User.create(
    username: Faker::Internet.username(specifier: 10),
    email: Faker::Internet.email,
    password: Faker::Internet.password,
    rank: rank_value,
    rank_points: rank_value * 1000,
    highest_rank: rank_value
  )

  user_image = URI.open(url)
  user.photo.attach(io: user_image, filename: "#{user['username']}.png", content_type: "image/png")
  user.save!

  puts ""
  puts "user: #{user.username} created with image"
  puts ""
end


# create users 10

puts 'Creating badges...'

def read_and_parse_url(url)
  playgrounds_api_serialized = URI.open(url).read
  JSON.parse(playgrounds_api_serialized)
end

# create playgrounds

def build_playground(json)

  excluded_addresses = [
    "2463 Rue West Broadway, Montréal, QC H4B 1K1, Canada",
    "7505 Bd Provencher, Montréal, QC H1S 2Y8, Canada",
    "4755 Rue Jarry E Ste 200C, Montreal, Quebec H1R 1X7, Canada",
    "4510 Rue West Broadway, Montréal, QC H4B 2A8, Canada"
  ]

  json["results"].each do |result|
    if result["photos"] && !excluded_addresses.include?(result["formatted_address"])
      playground = Playground.create(
        name: result["name"],
        address: result["formatted_address"],
        latitude: result["geometry"]["location"]["lat"],
        longitude: result["geometry"]["location"]["lng"]
      )

      puts "Playground #{playground.name} successfully created"

      photo_reference = result["photos"][0]["photo_reference"]
      photo_url = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=1000&photo_reference=#{photo_reference}&key=#{ENV['GMAPS_API']}"

      puts "Playground image url = #{photo_url}"

      playground_image = URI.open(photo_url)
      playground.photo.attach(io: playground_image, filename: "#{playground['name']}.png", content_type: "image/png")

      puts "Image given to #{playground.name}"

    end
  end
end

def create_playgrounds_from_url(url)
  json = read_and_parse_url(url)
  build_playground(json)
  return json["next_page_token"]
end

playgrounds_api_url = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=terrain%20de%20basketball%20montreal&key=#{ENV['GMAPS_API']}"
next_token = create_playgrounds_from_url(playgrounds_api_url)

playgrounds_api_url2 = "https://maps.googleapis.com/maps/api/place/textsearch/json?pagetoken=#{next_token}&query=terrain%20de%20basketball%20montreal&key=#{ENV['GMAPS_API']}"
next_token = create_playgrounds_from_url(playgrounds_api_url2)

playgrounds_api_url3 = "https://maps.googleapis.com/maps/api/place/textsearch/json?pagetoken=#{next_token}&query=terrain%30de%20basketball%20montreal&key=#{ENV['GMAPS_API']}"
next_token = create_playgrounds_from_url(playgrounds_api_url3)

playgrounds_api_url4 = "https://maps.googleapis.com/maps/api/place/textsearch/json?pagetoken=#{next_token}&query=terrain%30de%20basketball%20montreal&key=#{ENV['GMAPS_API']}"
next_token = create_playgrounds_from_url(playgrounds_api_url4)

playgrounds_api_url5 = "https://maps.googleapis.com/maps/api/place/textsearch/json?pagetoken=#{next_token}&query=terrain%30de%20basketball%20montreal&key=#{ENV['GMAPS_API']}"
next_token = create_playgrounds_from_url(playgrounds_api_url5)


5.times do
  day = rand(2..5)

  hour = rand(8..20)

  game = Game.new(
    start_date: "#{day} Sep 2022 #{hour}:00:00.000000000 UTC +00:00",
    end_date: "#{day} Sep 2022 #{hour + 1}:00:00.000000000 UTC +00:00",
    game_mode: rand(0..1),
    team_size: rand(1..3)
  )

  start_date = game.start_date

  game.end_date = start_date + 1.hour

  game.user = User.all.sample
  game.playground = Playground.all.sample
  game.save!

  # games_of_main_user << game
end

# give games to all playgrounds

Playground.all.each do |playground|

  playground_games = []

  3.times do

    day = rand(2..5)

    hour = rand(8..20)

    game = Game.new(
      start_date: "#{day} Sep 2022 #{hour}:00:00.000000000 UTC +00:00",
      end_date: "#{day} Sep 2022 #{hour + 1}:00:00.000000000 UTC +00:00",
      game_mode: rand(0..1),
      team_size: rand(1..3)
    )

    start_date = game.start_date

    game.end_date = start_date + 1.hour

    game.user = User.all.sample
    game.playground = playground
    game.save!

    playground_games << game
  end

  playground_games.each do |game|
    enum = game.team_size.to_i
    number_of_players = enum * 2

    puts "inside main user game. Team size enum is : #{enum}. Entering number_of_players.times with #{number_of_players} number of players."

    # creating players for the blue team

    if (enum == 1)
      player = User.all.sample
        unless game.players.include?(player)
          Player.create(
            user: player,
            confirmed_results: [true, false].sample,
            team: 1,
            game: game
          )
        end

      puts "player of the blue team: #{player} saved!"

    else
      (enum - 1).times do
        player = User.all.sample
        unless game.players.include?(player) || game.players.length == enum
          Player.create(
            user: player,
            confirmed_results: [true, false].sample,
            team: 1,
            game: game
          )
        end

        puts "player of the blue team: #{player} saved!"
      end
    end

    # creating players for the red team

    (enum - rand(0..1)).times do
      player = User.all.sample
        unless game.players.include?(player) || game.players.length == enum
          Player.create(
            user: player,
            confirmed_results: [true, false].sample,
            team: 0,
            game: game
          )
        end

      puts "player of the red team: #{player} saved!"
    end
  end
end

puts "------------------------------------------------------------------"
puts "------------------------------------------------------------------"
puts "------------------------------------------------------------------"
puts "------------------------------------------------------------------"

puts "hardcoding two games"

puts "------------------------------------------------------------------"
puts "------------------------------------------------------------------"
puts "------------------------------------------------------------------"
puts "------------------------------------------------------------------"

game_01 = Game.new(
  #  1 v 1
  # competitive
  # soeur madelaein
  # sept 2nd, 7pm

  #second user is the creator of the game

  start_date: "02 Sep 2022 19:00:00.000000000 UTC +00:00",
  end_date: "02 Sep 2022 20:00:00.000000000 UTC +00:00",
  game_mode: 0,
  team_size: 0
)

game_01.user = second_user

game_01.playground = Playground.find_by(name: "Parc Soeur-Madeleine-Gagnon basketball court")

game_01.save!


enum = game_01.team_size.to_i
number_of_players = enum * 2

if (enum == 1)
  player = User.all.sample
    unless game_01.players.include?(player)
      Player.create(
        user: player,
        confirmed_results: [true, false].sample,
        team: 1,
        game: game_01
      )
    end

  puts "player of the blue team: #{player} saved!"

else
  (enum - 1).times do
    player = User.all.sample
    unless game.players.include?(player) || game_01.players.length == enum
      Player.create(
        user: player,
        confirmed_results: [true, false].sample,
        team: 1,
        game: game_01
      )
    end

    puts "player of the blue team: #{player} saved!"
  end
end

# creating players for the red team

(enum - rand(0..1)).times do
  player = User.all.sample
    unless game_01.players.include?(player) || game_01.players.length == enum
      Player.create(
        user: player,
        confirmed_results: [true, false].sample,
        team: 0,
        game: game_01
      )
    end

  puts "player of the red team: #{player} saved!"

end

game_02 = Game.new(
  #  4 v 4
  # competitive
  # concordia gymnasium

  # red gets 3 players
  # blue gets 3 players

  start_date: "05 Sep 2022 13:00:00.000000000 UTC +00:00",
  end_date: "05 Sep 2022 14:00:00.000000000 UTC +00:00",
  game_mode: 1,
  team_size: 3
)

game_02.user = lebron

game_02.playground = Playground.find_by(name: "École du Petit-Chapiteau basketball court")

game_02.save!

Player.create(user: lebron, team: 0, game: game_02, confirmed_results: false)

2.times do
  Player.create(
    team: 0,
    game: game_02,
    confirmed_results: false,
    user: User.all.sample
  )
end

3.times do
  Player.create(
    team: 1,
    game: game_02,
    confirmed_results: false,
    user: User.all.sample
  )
end

# enum = game_02.team_size.to_i
# number_of_players = enum * 2

# puts "inside main user game. Team size enum is : #{enum}. Entering number_of_players.times with #{number_of_players} number of players."

# # creating players for the blue team

# if (enum == 1)
#   player = User.all.sample
#     unless game_02.players.include?(player)
#       Player.create(
#         user: player,
#         confirmed_results: [true, false].sample,
#         team: 1,
#         game: game_02
#       )
#     end

#   puts "player of the blue team: #{player} saved!"

# else
#   (enum - 1).times do
#     player = User.all.sample
#     unless game_02.players.include?(player) || game_02.players.length == enum
#       Player.create(
#         user: player,
#         confirmed_results: [true, false].sample,
#         team: 0,
#         game: game_02
#       )
#     end

#     puts "player of the blue team: #{player} saved!"
#   end
# end

# # creating players for the red team

# (enum - 1).times do
#   player = User.all.sample
#     unless game_02.players.include?(player) || game_02.players.length == enum
#       Player.create(
#         user: player,
#         confirmed_results: [true, false].sample,
#         team: 1,
#         game: game_02
#       )
#     end

#   puts "player of the red team: #{player} saved!"

# end
# game_02.playground = Playground.where(name: "Parc Soeur-Madeleine-Gagnon basketball")


puts '--------------------------------'
puts "Creating the main user..."
puts '--------------------------------'

main_user = User.create(username: "Jamie", email: "a@a.a", password: "meetball", rank: 4, rank_points: 4900, highest_rank: 4)

puts '--------------------------------'
puts "Main user #{main_user.username} created"
puts '--------------------------------'

main_user_photo_url = "https://res.cloudinary.com/meetball/image/upload/v1661799776/Avatars/Shaq_sezxaw.png"

main_user_image = URI.open(main_user_photo_url)
main_user.photo.attach(io: main_user_image, filename: "#{main_user['username']}.png", content_type: "image/png")
main_user.save!
puts "Image given to #{main_user.email}"

puts "Giving Badges to Main User"

rand(3..5).times do
  user_badge = UserBadge.new

  user_badge.user = main_user
  user_badge.badge = Badge.all.sample
  user_badge.save!

  puts ""
  puts ""
  puts "User_badges #{user_badge.badge.name} given to #{main_user.username}"
  puts ""
  puts ""
end

# create games for the main_user

# games_of_main_user = []

# give players to main_user's games

# games_of_main_user.each do |game|
#   enum = game.team_size.to_i
#   number_of_players = enum * 2

#   puts "inside main user game. Team size enum is : #{enum}. Entering number_of_players.times with #{number_of_players} number of players."

#   # creating players for the blue team

#   if (enum == 1)
#     player = User.all.sample
#       unless game.players.include?(player)
#         Player.create(
#           user: player,
#           confirmed_results: [true, false].sample,
#           team: 1,
#           game: game
#         )
#       end

#     puts "player: #{player} saved!"

#   else
#     (enum - 1).times do
#       player = User.all.sample
#       unless game.players.include?(player)
#         Player.create(
#           user: player,
#           confirmed_results: [true, false].sample,
#           team: 1,
#           game: game
#         )
#       end

#       puts "player of the blue team: #{player} saved!"
#     end
#   end

#   # creating players for the red team

#   (enum - rand(0..1)).times do
#     player = User.all.sample
#       unless game.players.include?(player)
#         Player.create(
#           user: player,
#           confirmed_results: [true, false].sample,
#           team: 0,
#           game: game
#         )
#       end

#     puts "player of the red team: #{player} saved!"
#   end
# end


# First game

puts 'Creating hardcoded games for main user...'

first_game = Game.new(
  start_date: "31 Aug 2022 14:00:00.000000000 UTC +00:00",
  end_date: "31 Aug 2022 15:00:00.000000000 UTC +00:00",
  game_mode: 0,
  team_size: 0
)

first_game.playground = Playground.all.sample
first_game.user = User.last
first_game.save

first_game_player1 = Player.new(
  team: 0,
  confirmed_results: true
)
first_game_player1.game = first_game
first_game_player1.user = User.last
first_game_player1.save

first_game_player2 = Player.new(
  team: 0,
  confirmed_results: true
)
first_game_player2.game = first_game
first_game_player2.user = second_user
first_game_player2.save

first_game_result = Result.new(
  red_score: 60,
  blue_score: 51,
  status: true
)
first_game_result.game = first_game
first_game_result.save



# Second game



second_game = Game.new(
  start_date: "28 Aug 2022 12:00:00.000000000 UTC +00:00",
  end_date: "28 Aug 2022 13:00:00.000000000 UTC +00:00",
  game_mode: 0,
  team_size: 1
)

second_game.playground = Playground.all.sample
second_game.user = User.last
second_game.save

second_game_player1 = Player.new(
  team: 0,
  confirmed_results: true
)
second_game_player1.game = second_game
second_game_player1.user = User.last
second_game_player1.save

second_game_player2 = Player.new(
  team: 0,
  confirmed_results: true
)
second_game_player2.game = second_game
second_game_player2.user = User.all.sample
second_game_player2.save

second_game_player3 = Player.new(
  team: 1,
  confirmed_results: true
)
second_game_player3.game = second_game
second_game_player3.user = User.all.sample
second_game_player3.save

second_game_player4 = Player.new(
  team: 1,
  confirmed_results: true
)
second_game_player4.game = second_game
second_game_player4.user = User.all.sample
second_game_player4.save

second_game_result = Result.new(
  red_score: 80,
  blue_score: 62,
  status: true
)
second_game_result.game = second_game
second_game_result.save




# Third game




third_game = Game.new(
  start_date: "25 Aug 2022 15:00:00.000000000 UTC +00:00",
  end_date: "25 Aug 2022 16:00:00.000000000 UTC +00:00",
  game_mode: 0,
  team_size: 2
)

third_game.playground = Playground.all.sample
third_game.user = User.last
third_game.save

third_game_player1 = Player.new(
  team: 0,
  confirmed_results: true
)
third_game_player1.game = third_game
third_game_player1.user = User.last
third_game_player1.save

third_game_player2 = Player.new(
  team: 0,
  confirmed_results: true
)
third_game_player2.game = third_game
third_game_player2.user = User.all.sample
third_game_player2.save

third_game_player3 = Player.new(
  team: 0,
  confirmed_results: true
)
third_game_player3.game = third_game
third_game_player3.user = User.all.sample
third_game_player3.save

third_game_player4 = Player.new(
  team: 1,
  confirmed_results: true
)
third_game_player4.game = third_game
third_game_player4.user = User.all.sample
third_game_player4.save

third_game_player5 = Player.new(
  team: 1,
  confirmed_results: true
)
third_game_player5.game = third_game
third_game_player5.user = User.all.sample
third_game_player5.save

third_game_player6 = Player.new(
  team: 1,
  confirmed_results: true
)
third_game_player6.game = third_game
third_game_player6.user = User.all.sample
third_game_player6.save

third_game_result = Result.new(
  red_score: 45,
  blue_score: 58,
  status: true
)
third_game_result.game = third_game
third_game_result.save


puts '--------------------------------'
puts ""
puts '--------------------------------'

puts "Seed completed with success"

puts '--------------------------------'
