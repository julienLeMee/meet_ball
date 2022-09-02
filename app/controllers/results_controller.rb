class ResultsController < ApplicationController
  before_action :set_game, only: %i[new create]

  def show
    @user = current_user
    @result = Result.find(params[:id])
    @game = @result.game
    @player = Player.find_by(user: @user, game: @game)
    @players = @game.players
    average_rank
  end

  def new
    @result = Result.new
    average_rank
  end

  def create
    @player = Player.where(user_id: current_user.id).first
    @player.confirmed_results = true
    @player.save
    @result = Result.new(result_params)
    build_result
    @result.game = @game
    if @result.save
      redirect_to result_path(@result), notice: "Wainting on confirmation"
    else
      render :new, status: 422
    end
  end

  def confirmed_results
    @status == true
  end

  private

  def result_params
    params.require(:result).permit(:red_score, :blue_score)
  end

  def set_game
    @game = Game.find(params[:game_id])
  end

  def build_result
    red_score = params[:result][:red_score]
    blue_score = params[:result][:blue_score]

    @result.red_score = red_score
    @result.blue_score = blue_score
  end

  def average_rank
    @average_rank = 0
    @game.players.each do |player|
      @average_rank += User.ranks[player.user.rank] if player.user.rank
    end
    @average_rank /= @game.players.count if @game.players.count.positive?
  end
end
