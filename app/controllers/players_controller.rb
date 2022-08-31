class PlayersController < ApplicationController
  def create
    @player_team = params[:player][:team].to_i
    @game = Game.find(params[:player][:game].to_i)

    @player = Player.new(confirmed_results: false, user: current_user)
    @player.team = @player_team
    @player.game = @game

    if @player.save
      redirect_to game_path(@game)
    else
      render 'games/show', status: :unprocessable_entity
    end
  end

  def update
    @game = Game.find(params[:game_id])
    @player = @game.players.where(user_id: current_user.id)
    @confirmed = params[:player][:confirmed_results]
    @player.update(confirmed_results: @confirmed)
    majority = @game.team_size.to_i + 1
    players_confirmed_score = @game.players.count { |player| player.confirmed_results }
    if players_confirmed_score >= majority
      result = @game.result
      result.status = true
      result.save
      add_or_remove_rank_points if @game.game_mode == "competitive"
    end
    redirect_to result_path(@game)
  end

  def destroy
    @player = Player.find(params[:id])
    @player.destroy
    redirect_to game_path(@game), status: 303
  end

  private

  def check_winner
    if @game.result.red_score > @game.result.blue_score
      "red_team"
    elsif @game.result.red_score < @game.result.blue_score
      "blue_team"
    else
      "draw"
    end
  end

  def attribute_rank(player)
    if player.user.rank_points >= 0 && player.user.rank_points < 1000
      player.user.rank = 0
    elsif player.user.rank_points >= 1000 && player.user.rank_points < 2000
      player.user.rank = 1
    elsif player.user.rank_points >= 2000 && player.user.rank_points < 3000
      player.user.rank = 2
    elsif player.user.rank_points >= 3000 && player.user.rank_points < 4000
      player.user.rank = 3
    elsif player.user.rank_points >= 4000 && player.user.rank_points < 5000
      player.user.rank = 4
    elsif player.user.rank_points >= 5000
      player.user.rank = 5
    end
    player.user.save
  end

  def add_or_remove_rank_points
    case check_winner
    when "red_team"
      @game.players.each do |player|
        if player.team == "red"
          player.user.rank_points += 200
          player.user.rank_points += (@game.result.red_score - @game.result.blue_score)
        else
          player.user.rank_points -= 200
          player.user.rank_points -= (@game.result.red_score - @game.result.blue_score)
        end

        player.user.rank_points = 0 if player.user.rank_points.negative?

        player.user.save
        attribute_rank(player)
      end
    when "blue_team"
      @game.players.each do |player|
        if player.team == "blue"
          player.user.rank_points += 200
          player.user.rank_points += (@game.result.red_score - @game.result.blue_score)
        else
          player.user.rank_points -= 200
          player.user.rank_points -= (@game.result.red_score - @game.result.blue_score)
        end

        player.user.rank_points = 0 if player.user.rank_points.negative?

        player.user.save
        attribute_rank(player)
      end
    end
  end
end
