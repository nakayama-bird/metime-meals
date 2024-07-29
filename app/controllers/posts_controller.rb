class PostsController < ApplicationController
  skip_before_action :require_login, only: %i[index show search]
  before_action :set_post, only: %i[edit update destroy]
  before_action :set_search_posts_form
  def index
    posts = if (tag_name = params[:tag_name])
      Post.with_tag(tag_name)
    else
      Post.includes(:user)
    end
    @posts = posts.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
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

  def edit;end

  def update
    @post.assign_attributes(post_params)
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
      params.require(:post).permit(:genre, :restaurant_name, :address, :body, :amount, post_images: [] )
    end

    def set_post
      @post = current_user.posts.find(params[:id])
    end

    def set_search_posts_form
      @search_form = SearchPostsForm.new(search_post_params)
    end

    def search_post_params
      params.fetch(:q, {}).permit(:address_or_body, :genre_select)
    end
end
