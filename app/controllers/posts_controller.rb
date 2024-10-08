class PostsController < ApplicationController
  skip_before_action :require_login, only: %i[index show search]
  before_action :set_post, only: %i[edit update destroy]
  before_action :set_search_posts_form
  include ImageValidatable
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
    unless validate_images(post_params[:post_images])
      flash.now[:alert] = '不適切な画像が含まれています'
      return render :edit, status: :unprocessable_entity
    end
    # タグの処理と保存
    if @post.save_with_tags(tag_names: params.dig(:post, :tag_names).split(',').uniq)
      redirect_to posts_path, success: '投稿に成功しました'
    else
      flash.now[:alert] = '投稿に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit; end

  def update
    @post.assign_attributes(post_params)

    # 画像が不適切であれば早期リターン
    unless validate_images(post_params[:post_images])
      flash.now[:alert] = '不適切な画像が含まれています'
      return render :edit, status: :unprocessable_entity
    end

    # タグの処理と更新
    if @post.save_with_tags(tag_names: params.dig(:post, :tag_names).split(',').uniq)
      redirect_to post_path(post_params), success: '投稿の更新に成功しました'
    else
      flash.now[:alert] = '投稿の更新に失敗しました'
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
end
