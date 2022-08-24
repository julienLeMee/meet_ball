class GamesController < ApplicationController
  before_action :set_games, only: %i[show edit update destroy]
  before_action :set_user, only: %i[my_games]
  before_action :set_playground, only: %i[new create]

  def new
    @game = Game.new
  end

  def show
  end

  def create
    @game = Game.new(game_params)

    build_game

    @game.playground = @playground
    @game.user = current_user

    save_reservation(:new)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def my_games
    @my_games = Game.where(user: @user)
  end

  private

  def game_params
    params.require(:game).permit(:start_date, :end_date, :game_mode, :team_size)
  end

  def set_user
    @user = current_user
  end

  def set_games
    @game = Game.find(params[:id])
  end

  def set_playground
    @playground = Playground.find(params[:playground_id])
  end

  def build_game
    @game.start_date = params[:game][:start_date]
    @game.end_date = params[:game][:end_date]
  end
end
