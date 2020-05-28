class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def edit
      @user = User.find(params[:id])
  end

  def update
  end



  def destroy
    reset_session
    redirect_to root_path, notice: 'ログアウトしました。'
  end


  def logout
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end