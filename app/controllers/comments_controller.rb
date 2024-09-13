class CommentsController < ApplicationController
  before_action :authenticate_user!

  def edit
    render locals: { resource_comment: resource_comment }
  end

  def create
    comment = Comment.new(comment_params)
    comment.user = current_user
    comment.post = resource_post

    if comment.save
      redirect_to post, notice: 'Comment was successfully created.'
    else
      redirect_to post, alert: 'Failed to create comment.'
    end
  end

  def update
    if resource_comment.update(comment_params)
      redirect_to resource_comment.post, notice: 'Comment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    resource_comment.destroy

    redirect_to @comment.post, notice: 'Comment was successfully destroyed.'
  end

  private

  def resource_comment
    @resource_comment = Comment.find(params[:id])
  end

  def resource_post
    Post.find(params[:post_id])
  end

  def comment_params
    (params[:comment] || ActionController::Parameters.new).permit(:body, :post_id)
  end
end
