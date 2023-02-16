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

      render :new
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
      flash.now[:alert] = 'При попытке изменить данные возникли ошибки'

      render :edit
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

  private

  def user_params
    params.require(:user).permit(:name, :nickname, :email, :password, :password_confirmation, :color)
  end
end
