class Mypage::PostsController < ApplicationController
  def index
    @posts = Post.includes(:user, :tags).where(user_id: current_user.id).order(created_at: :desc).page params[:page]
  end
end
