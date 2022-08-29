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
    @player.update(confirmed_results: true)
    majority = @game.team_size.to_i + 1
    players_confirmed_score = @game.players.count {|player| player.confirmed_results }
    if players_confirmed_score >= majority
      result = @game.result
      result.status = true
      result.save
    end
    redirect_to result_path(@game)
  end
end
