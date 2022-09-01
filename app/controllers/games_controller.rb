class GamesController < ApplicationController
  before_action :set_games, only: %i[show edit update destroy]
  before_action :set_user, only: %i[my_games create_choose_playground]
  skip_before_action :authenticate_user!, only: %i[show]

  def show
    @games = Game.find(params[:id])

    @player = Player.new

    @average_rank = 0

    @game.players.each do |player|
      @average_rank += User.ranks[player.user.rank] if player.user.rank
    end

    @average_rank /= @game.players.count if @game.players.count.positive?

    @team_red_full = team_full?(team: 0)
    @team_blue_full = team_full?(team: 1)
  end

  def new_choose_playground
    @game = Game.new
  end

  def create_choose_playground
    @game = Game.new(game_params)

    build_create_choose_playground

    if @game.save
      Player.create(game: @game, user: @user, team: 0, confirmed_results: false)
      redirect_to game_path(@game)
    else
      render :new_choose_playground, status: 422
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def my_games
    @games = Game.where(user: @user)
  end

  private

  def team_full?(team)
    @game.players.where(team).count >= @game.team_size.to_i
  end

  def game_params
    params.require(:game).permit(:start_date, :playground_id)
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

  def build_create_choose_playground
    game_mode = params[:game][:game_mode]
    team_size = params[:game][:team_size]

    @game.game_mode = game_mode.to_i
    @game.team_size = team_size.to_i

    @game.user = @user

    @game.end_date = @game.start_date + 1.hour

    @playground = Playground.find(params[:game][:playground].to_i)
    @game.playground = @playground
  end
end
