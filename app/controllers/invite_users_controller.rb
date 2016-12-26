class InviteUsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user].permit(:email))
    @user.inviting = true

    if @user.save
      redirect_to invite_users_path, flash: { success: t(".user_created") }
    else
      flash.now[:alert] = t(".could_not_create_user")
      render :new
    end
  end
end