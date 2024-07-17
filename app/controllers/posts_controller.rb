class PostsController < ApplicationController
  skip_before_action :require_login, only: %[index]
  def index
    @posts = Post.includes(:user).order(created_at: :desc)
  end
end
