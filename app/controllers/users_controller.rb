class UsersController < ApplicationController
  def new
    if current_user
      redirect_to "/users/show/#{session[:user_id]}"
    else
      render "/users/new"
    end
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      puts "User #{session[:user_id]}"
      redirect_to "/users/show/#{session[:user_id]}"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to "/users/new" 
    end
  end

  def show
    @secrets = current_user.secrets
    @likes = current_user.secrets_liked
  end

  def edit
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
