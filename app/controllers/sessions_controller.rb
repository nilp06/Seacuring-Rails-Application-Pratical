class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user.present?
      session[:user_id] = @user.id
      cookies[:user_name] = @user.name
    else
      redirect_to new_users_path, flash: { success: 'Logged in successfully.' }
    end
  end

  def destroy
    session.delete(:user_id)
    cookies.delete(:user_name)
    redirect_to root_path, flash: { success: 'Logged out successfully.' }
  end
end
