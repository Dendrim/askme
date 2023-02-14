class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit(:name, :nickname, :email, :password)

    new_user = User.new(user_params)
    new_user.save

    session[:user_id] = new_user.id

    redirect_to root_path, notice: "Вы успешно зарегистрировались"
  end
end
