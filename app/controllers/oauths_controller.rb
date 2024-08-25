class OauthsController < ApplicationController
  skip_before_action :require_login, only: %i[oauth callback]
  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    @user = login_from(provider)
    unless @user
      sorcery_fetch_user_hash(provider)
      @user = User.find_by(email: @user_hash[:user_info]['email'])
      if @user
        @user.add_provider_to_user(provider, @user_hash[:uid].to_s)
      else
        @user = create_from(provider)
      end
      reset_session
      auto_login(@user)
    end
    redirect_to root_path, success: 'Googleアカウントでログインしました'
  rescue StandardError
    redirect_to root_path, alert: 'Googleアカウントでログインに失敗しました'
  end

  private

  def auth_params
    params.permit(:code, :provider)
  end
end
