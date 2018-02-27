class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to "/users/show"
    else
      render "sessions/new"
    end
  end

  def create
    @user = User.find_by_email(params[:user][:email]) 
    if @user
      if @user.try(:authenticate, params[:user][:password])
        session[:user_id] = @user.id
        redirect_to "/users/show/#{session[:user_id]}"
      else 
        flash[:errors]=["Password doesn't match"]
        redirect_to "/sessions/new"
      end
    else
      flash[:errors]=["User not found"]
      redirect_to "/sessions/new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to "/sessions/new" 
  end
  private
  def login_params
    params.require(:user).permit(:email, :password)
  end

end
