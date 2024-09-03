class Mypage::ProfilesController < ApplicationController
  before_action :set_user, only: %i[edit update]

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to mypage_profiles_path, success: 'ユーザー情報の更新に成功しました'
    else
      flash.now['alert'] = 'ユーザー情報の更新に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  def show; end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:name, :avatar, :avatar_cache, :age, :gender)
  end
end
