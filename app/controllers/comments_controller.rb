# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @comment = Comment.new(post_id: resource_post.id)

    render locals: {
      post: resource_post,
      parent_id: comment_params[:parent_id],
      comment: @comment
    }
  end

  def edit
    render locals: {
      post: resource_post,
      parent_id: comment_params[:parent_id],
      comment: resource_comment
    }
  end

  def create
    comment = Comment.new(comment_params)
    comment.author = current_user
    comment.post = resource_post
    comment.parent_id = comment_params[:parent_id]

    if comment.save
      flash[:success] = I18n.t('comment.create')
      redirect_to resource_post
    else
      flash.now[:error] = I18n.t('error')
      render :new
    end
  end

  def update
    if resource_comment.update(comment_params)
      flash[:success] = I18n.t('comment.update')
      redirect_to resource_comment.post
    else
      flash.now[:error] = I18n.t('error')
      render :edit
    end
  end

  def destroy
    resource_comment.destroy

    flash[:success] = I18n.t('comment.destroy')
    redirect_to resource_comment.post
  end

  private

  def resource_comment
    @resource_comment = Comment.find(params[:id])
  end

  def resource_post
    @resource_post = Post.find(params[:post_id])
  end

  def comment_params
    (params[:comment] || ActionController::Parameters.new).permit(:body, :post_id, :parent_id)
  end
end
