class UsersController < ApplicationController
  def new
    redirect_to root_path and return if current_user
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path(email: @user.email), notice: t('messages.controllers.users.user_successfully_created')
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
