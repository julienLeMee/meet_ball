class ResultsController < ApplicationController
  before_action :set_game, only: %i[new create]

  def show
    @user = current_user
    @result = Result.find(params[:id])
    @game = @result.game
    @player = Player.find_by(user: @user, game: @game)
  end

  def new
    @result = Result.new
  end

  def create
    @result = Result.new(result_params)
    build_result
    @result.game = @game
    if @result.save
      redirect_to result_path(@result)
    else
      render :new, status: 422
    end
  end

  def confirmed_results
    @status == true
  end

  def add_or_remove_rank_points
    case check_winner
    when "red_team"
      @results.game.players.each do |player|
        if player.team == "red"
          player.rank_points += 200
          player.rank_points += (@results.red_score - @results.blue_score)
        else
          player.rank_points -= 200
          player.rank_points -= (@results.red_score - @results.blue_score)
        end
      end
    when "blue_team"
      @results.game.players.each do |player|
        if player.team == "blue"
          player.rank_points += 200
          player.rank_points += (@results.red_score - @results.blue_score)
        else
          player.rank_points -= 200
          player.rank_points -= (@results.red_score - @results.blue_score)
        end
      end
    end

    attribute_rank
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

  def check_winner
    if @result.red_score > @result.blue_score
      "red_team"
    elsif @result.red_score < @result.blue_score
      "blue_team"
    else
      "draw"
    end
  end

  def attribute_rank
    if @user.rank_points >= 0 && @user.rank_points < 1000
      @user.rank = 0
    elsif @user.rank_points >= 1000 && @user.rank_points < 2000
      @user.rank = 1
    elsif @user.rank_points >= 2000 && @user.rank_points < 3000
      @user.rank = 2
    elsif @user.rank_points >= 3000 && @user.rank_points < 4000
      @user.rank = 3
    elsif @user.rank_points >= 4000 && @user.rank_points < 5000
      @user.rank = 4
    elsif @user.rank_points >= 5000
      @user.rank = 5
    end
    @user.save
  end
end
