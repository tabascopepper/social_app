# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.where(user_id: current_user.followings.pluck(:id)).order(created_at: :desc)
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: I18n.t('posts.success')
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
