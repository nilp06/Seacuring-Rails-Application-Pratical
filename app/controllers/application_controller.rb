class ApplicationController < ActionController::Base
  helper_method %i[user_signed_in?, current_user]
  before_action :authenticate_user

  def current_user
    @current_user ||= session[:user_id] && User.find_by(id: session[:user_id])
  end

  def user_signed_in?
    !current_user.nil?
  end

  def authenticate_user
    return if user_signed_in?

    redirect_to root_path, flash: { danger: 'You must logged in to see this page.' }
  end

  def redirect_if_authenticated
    return unless user_signed_in?

    redirect_to root_path, flash: { danger: 'You are already logged in.' }
  end
end
