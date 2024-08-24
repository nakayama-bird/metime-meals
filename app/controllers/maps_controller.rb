class MapsController < ApplicationController
  skip_before_action :require_login, only: %i[index search]
  before_action :set_search_posts_form
  def index
    @posts = Post.includes(:user).order(created_at: :desc)
  end

  def search
    @posts = @search_form.search.includes(:user).order(created_at: :desc)
  end

  private

  def set_search_posts_form
    @search_form = SearchPostsForm.new(search_post_params)
  end

  def search_post_params
    params.fetch(:q, {}).permit(:address_or_name, :genre_select)
  end
end
