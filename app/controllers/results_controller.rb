class ResultsController < ApplicationController
  before_action :set_game, only: %i[new create]

  def show
    @result = Result.find(params[:id])
  end

  def new
    @result = Result.new
  end

  def create
    @result = Result.new(result_params)
    build_result
    @result.game = @game
    if @result.save
      redirect_to result_path(@result), notice: 'Result was successfully created.'
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
end
