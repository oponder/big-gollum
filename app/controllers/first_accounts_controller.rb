class FirstAccountsController < ApplicationController
  skip_before_filter :authenticate_user!

  def new
    @first_account = User.new
  end

  def create
    @first_account = User.new(resource_params)

    if @first_account.save
      sign_in :user, @first_account
      redirect_to edit_settings_path
    else
      render :new
    end

  end

  def resource_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end
end
