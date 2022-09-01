require 'open-uri'

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

    @playground_id = get_playground_id
  end

  def playgrounds_nearby
    @playgrounds = Playground.all
    @playgrounds = @playgrounds.to_a
  end

  private

  def get_playground_id
    url = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=#{@playground.address}&key=#{ENV['GMAPS_API']}"
    playground_api_serialized = URI.open(url).read
    json = JSON.parse(playground_api_serialized)
    playground_id = json["results"][0]["place_id"]

    playground_call(playground_id)
  end

  def playground_call(playground_id)
    # url = "https://maps.googleapis.com/maps/api/place/details/json?fields=name%2Crating%2Cformatted_phone_number&place_id=#{playground_id}&key=#{ENV['GMAPS_API']}"
    # raise
  end
end
