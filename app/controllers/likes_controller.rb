class LikesController < ApplicationController
  def create
    secret = Secret.find_by_id(params[:id])
    user = User.find_by_id(session[:user_id])
    @like = Like.create(user:user,secret:secret)
    redirect_to "/secrets"
  end

  def destroy
    @d_like = Like.find_by(user_id: current_user.id, secret_id: params[:id])
    @d_like.destroy
    redirect_to "/secrets"
  end
end
