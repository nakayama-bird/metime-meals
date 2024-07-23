class MapsController < ApplicationController
  def index
    @posts = Post.includes(:user).order(created_at: :desc)
  end
end
