class UsersController < ApplicationController
  before_action :authenticate_user!, expect: [:index]

  def index
  end

  def mypage
    @user = current_user
  end

  def profile
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to users_mypage_path
    else
      render :profile, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :prefecture_id, :age_id, :gender_id,
                                :job_id, :introduction)
  end
end
