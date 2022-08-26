class PlayersController < ApplicationController
  def join_team
    if value == 0
      @player.team = 0
    elsif value == 1
      @player.team = 1
    end
    @player.save
  end
end
