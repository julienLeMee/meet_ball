class PlaygroundsController < ApplicationController
  def index
    @playgrounds = Playground.all
  end

  def show
    @playground = Playground.find(params[:id])
    @games = Game.where(playground_id: @playground)
  end

  def playgrounds_nearby
  end
end
