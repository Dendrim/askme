class SessionsController < ApplicationController
  def new
  end

  def destroy
    session.delete(:user_id)

    redirect_to root_path, notice: 'Вы вышли из аккаунта'
  end

  def create
    user_params = params.require(:session)

    user = User.find_by(email: user_params[:email])&.authenticate(user_params[:password])

    if user.present?
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Вы вошли на сайт'
    else
      flash[:alert] = 'Неправильный email или пароль'
      redirect_to new_session_path
    end
  end
end
