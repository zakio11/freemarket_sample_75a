class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def edit
    # @user = user.find(params[:id])
  end

  def update
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
