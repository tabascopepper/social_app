# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    render locals: { posts_collection: posts_collection }
  end

  def show
    render locals: {
      post: resource_post,
      comment: resource_comment
    }
  end

  def new
    @post = Post.new(post_params)

    render locals: { post: @post }
  end

  def edit
    render locals: { resource_post: resource_post }
  end

  def create
    post = Post.new(post_params)
    post.author = current_user

    if post.save
      flash[:success] = I18n.t('posts.create')
      redirect_to posts_path
    else
      flash.now[:error] = I18n.t('error')
      render :new
    end
  end

  def update
    if resource_post.update(post_params)
      flash[:success] = I18n.t('posts.update')
      redirect_to resource_post
    else
      flash.now[:error] = I18n.t('error')
      render :edit
    end
  end

  def destroy
    resource_post.destroy!

    flash[:success] = I18n.t('posts.destroy')
    redirect_to posts_path
  end

  private

  def resource_comment
    Comment.new(post_id: resource_post.id)
  end

  def resource_post
    @resource_post = Post.find_by(id: params[:id])
  end

  def posts_collection
    @posts_collection = Post.where(author_id: current_user.id)
  end

  def post_params
    (params[:post] || ActionController::Parameters.new).permit(:title, :body)
  end
end
