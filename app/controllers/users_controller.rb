class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update destroy]
  def show
    @user = current_user
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

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email)
  end
end
