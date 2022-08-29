class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update destroy attribute_rank]

  def show
    @user = current_user
    # @message = Message.new
    # @chatroom = Chatroom.new
    # @message.chatroom = @chatroom
    # @message.user = @user
    # raise
    # @chatroom = Chatroom.find_by(user: @user, chatroom: @chatroom)
    # @chatroom = Chatroom.where(name: "general")
  end

  def edit
  end

  def update
    @user.update(user_params)
    if @user.save
      redirect_to dashboard_path(@user)
    else
      render :show, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy

    redirect_to dashboard_path, status: :see_other
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

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:username, :photo, :email)
  end
end
