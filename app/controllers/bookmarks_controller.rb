class BookmarksController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    current_user.bookmark(post)
    redirect_to request.referer, success: '投稿をお気に入りしました'
  end

  def destroy
    post = current_user.bookmarks.find(params[:id]).post
    current_user.unbookmark(post)
    redirect_to request.referer, success: '投稿のお気に入りを解除しました', status: :see_other
  end
end
