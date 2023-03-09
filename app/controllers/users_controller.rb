class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Вы успешно зарегистрировались'
    else
      flash.now[:alert] = 'Вы неправильно заполнили поля формы регистрации'
      flash[:user_errors] = @user.errors.full_messages
      redirect_to new_user_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to root_path, notice: 'Вы успешно изменили данные'
    else
      flash[:alert] = 'Вы неправильно заполнили поля формы регистрации'
      flash[:user_errors] = @user.errors.full_messages

      redirect_to edit_user_path
    end
  end

  def destroy
    @user = User.find(params[:id])

    if @user.id == session[:user_id]
      @user.destroy
      session.delete(:user_id)
    end

    redirect_to root_path, notice: 'Пользователь был успешно удален'
  end

  def reset_color
    @user = User.find(params[:id])

    if @user.id == session[:user_id]
      @user.set_default_navbar_color
      flash[:notice] = "Цвет успешно сброшен"
    end

    redirect_to edit_user_path(@user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :nickname, :email, :password, :password_confirmation, :color)
  end
end
