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
  end
end
