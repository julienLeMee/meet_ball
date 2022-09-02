namespace :pitch do
  desc 'reset data after pitch'
  task reset: :environment do
    puts 'launching reset task...'
    Message.destroy_all

    UserBadge.last.destroy

    Result.last.destroy

    Player.last.destroy
    Player.last.destroy
    Player.last.destroy
    Player.last.destroy

    Game.last.destroy

    user = User.last
    user.rank_points = 4900
    user.rank = 4
    user.highest_rank = 4
    user.save!

    puts 'Data resetted!'
  end
end
