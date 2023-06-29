class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: %i[new create]
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:user][:email])
    if @user.present? && @user.authenticate(user: params[:user][:password])
      reset_session
      session.update.old_values.except('session_id')
      session[:user_id] = @user.id
      redirect_to root_path, flash: { success: 'Logged in successfully.' }
    else
      redirect_to new_users_path, flash: { success: 'Email or password Invalid.' }
    end
  end

  def destroy
    session.clear
    cookies.clear
    redirect_to root_path, flash: { success: 'Logged out successfully.' }
  end
end
