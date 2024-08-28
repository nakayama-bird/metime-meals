class PostsController < ApplicationController
  skip_before_action :require_login, only: %i[index show search]
  before_action :set_post, only: %i[edit update destroy]
  before_action :set_search_posts_form
  def index
    posts = if (tag_name = params[:tag_name])
              Post.preload(:tags).with_tag(tag_name)
            else
              Post.includes(:tags, :user)
            end
    @posts = posts.order(created_at: :desc).page params[:page]
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    # digメソッドでネストしたハッシュを参照する
    if validate_images(post_params[:post_images])
      if @post.save_with_tags(tag_names: params.dig(:post, :tag_names).split(',').uniq)
        redirect_to posts_path, success: '投稿に成功しました'
      else
        flash.now[:alert] = '投稿に失敗しました'
        render :new, status: :unprocessable_entity
      end
    else
      flash.now[:alert] = '不適切な画像が含まれています'
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit; end

  def update
    @post.assign_attributes(post_params)
    if validate_images(post_params[:post_images])
      if @post.save_with_tags(tag_names: params.dig(:post, :tag_names).split(',').uniq)
        redirect_to post_path(post_params), success: '投稿の更新に成功しました'
      else
        flash.now[:alert] = '投稿の更新に失敗しました'
        render :edit, status: :unprocessable_entity
      end
    else
      flash.now[:alert] = '不適切な画像が含まれています'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy!
    redirect_to posts_path, success: '投稿を削除しました'
  end

  def search
    @posts = @search_form.search.includes(:user).order(created_at: :desc)
  end

  private

  def post_params
    params.require(:post).permit(:genre, :restaurant_name, :address, :body, :rating, :amount, post_images: [])
  end

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def set_search_posts_form
    @search_form = SearchPostsForm.new(search_post_params)
  end

  def search_post_params
    params.fetch(:q, {}).permit(:address_or_name, :genre_select)
  end

  def validate_images(post_images)
    return true if post_images.blank? || post_images.all?(&:blank?)

    inappropriate_images = []
    post_images.each do |image|
      result = Vision.image_analysis(image)
      inappropriate_images << image unless result
    end
    if inappropriate_images.any?
      return false
    end

    true
  end
end
