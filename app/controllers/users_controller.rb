class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def edit
      @user = User.find(params[:id])
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end



  def destroy
    reset_session
    redirect_to root_path, notice: 'ログアウトしました。'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
