class MapsController < ApplicationController
  skip_before_action :require_login, only: %i[index]
  before_action :set_search_posts_form
  def index
    if search_post_params.present?
      @posts = @search_form.search.includes(:user, :tags)
      @map_center_lat = params.dig(:q, :map_center_lat)
      @map_center_lng = params.dig(:q, :map_center_lng)
    else
      @posts = Post.includes(:user, :tags)
    end
  end

  # def search
  #   @posts = @search_form.search.includes(:user).order(created_at: :desc)
  # end

  private

  def set_search_posts_form
    @search_form = SearchPostsForm.new(search_post_params)
  end

  def search_post_params
    params.fetch(:q, {}).permit(:address_or_name, :genre_select, :map_center_lat, :map_center_lng)
  end
end
