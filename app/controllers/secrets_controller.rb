class SecretsController < ApplicationController
  def index
    @secrets = Secret.all
    puts "User #{session[:user_id]}"
  end

  def create
    @secret = Secret.new(secret_params)
    @secret.user = current_user
    @secret.save
    redirect_to "/secrets"
  end

  def destroy
    @d_secret = Secret.find(params[:id])
    @d_secret.destroy
    redirect_to "/users/show/#{session[:user_id]}"
  end

  private
  def secret_params
    params.require(:secret).permit(:content)
  end
end
