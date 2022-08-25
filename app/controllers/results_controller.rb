class ResultsController < ApplicationController
  def show
    @result = Result.find(params[:id])
  end

  def new
    @result = Result.new
  end
end
