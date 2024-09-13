# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    render locals: { users_collection: users_collection }
  end

  def follow
    current_user.follow(resource_user)
    flash[:success] = I18n.t('user.follow')
    redirect_to users_url
  end

  def unfollow
    current_user.unfollow(resource_user)
    flash[:success] = I18n.t('user.unfollow')
    redirect_to users_url
  end

  private

  def users_collection
    @users_collection = User.where.not(id: current_user)
  end

  def users_params
    (params[:user] || ActionController::Parameters.new).permit(:title, :body)
  end

  def resource_user
    @resource_user = User.find(params[:id])
  end
end
