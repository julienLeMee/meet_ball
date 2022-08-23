class PlaygroundsController < ApplicationController
  def index
    @playgrounds = Playground.all
  end

  def show
    @playground = Playground.find(params[:id])
  end
end
