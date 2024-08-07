class OauthsController < ApplicationController
  skip_before_action :require_login, only: [:oauth, :callback]
  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    if @user = login_from(provider)
      redirect_to root_path, success: 'Googleアカウントでログインしました'
    else
      begin
        @user = create_from(provider)
        reset_session
        auto_login(@user)
        redirect_to root_path, success: 'Googleアカウントでログインしました'
      rescue
        redirect_to root_path, danger: 'Googleアカウントでログインに失敗しました'
      end
    end
  end

  private

  def auth_params
    params.permit(:code, :provider)
  end

end
