class LikesController < ApplicationController
  skip_before_action :require_login

  def index
  end
  def create
    Like.create(like_params)
    redirect_to '/secrets/new'
  end

  def destroy
    @like =Like.find(params[:id])
    @like.destroy if current_user === @like.user
    redirect_to '/secrets/new'
  end

private
  def like_params
    params.require(:like).permit(:secret_id).merge(user: current_user)
  end

end
