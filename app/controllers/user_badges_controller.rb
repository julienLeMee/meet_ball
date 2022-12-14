class UserBadgesController < ApplicationController
  def create
    @result = Result.find(params[:result_id])
    @user_badge = UserBadge.create(user_badges_params)
    if @user_badge.save
      redirect_to result_path(@result), notice: "Badge #{@user_badge.badge.name.capitalize} successfully given to #{@user_badge.user.username}"
    else
      render 'results/show', status: :unprocessable_entity
    end
  end

  private

  def user_badges_params
    params.permit(:user_id, :badge_id)
  end
end
