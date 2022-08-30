class PlaygroundsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  skip_before_action :authenticate_user!, only: %i[index show playgrounds_nearby]

  def home
  end

  def index
    @user = current_user
    @playgrounds = Playground.all

    if params[:search].present?
      @playgrounds = Playground.where("name ILIKE ? OR description ILIKE ?", "%#{params[:search][:name]}%", "%#{params[:search][:name]}%")
    else
      @playgrounds = Playground.all
    end

  end

  def show
    @playground = Playground.find(params[:id])
    @games = Game.where(playground_id: @playground)
  end

  def playgrounds_nearby
    @playgrounds = Playground.all
    @playgrounds = @playgrounds.to_a
  end
end
