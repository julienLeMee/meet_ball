class UsersController < ApplicationController
  def show
    @user = current_user
  end

  def edit
  end

  def update
  end
end
