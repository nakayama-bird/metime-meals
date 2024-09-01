class Mypage::BookmarkPostsController < ApplicationController
  def index
    @posts = current_user.bookmark_posts.includes(:user, :tags).order(created_at: :desc).page(params[:page])
  end
end
