class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy reset_color]
  before_action :authorize_user, only: %i[edit update destroy reset_color]

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
  end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: 'Вы успешно изменили данные'
    else
      flash[:alert] = 'Вы неправильно заполнили поля формы регистрации'
      flash[:user_errors] = @user.errors.full_messages

      redirect_to edit_user_path(current_user)
    end
  end

  def destroy
    @user.destroy
    session.delete(:user_id)

    redirect_to root_path, notice: 'Пользователь был успешно удален'
  end

  def show
    @questions = @user.questions.order('created_at DESC')
    @question = Question.new(user: @user)
  end

  private

  def authorize_user
    redirect_with_alert unless current_user == @user
  end

  def set_user
    @user = User.where(nickname: params[:nickname])[0]
  end

  def user_params
    params.require(:user).permit(:name, :nickname, :email, :password, :password_confirmation, :color)
  end
end
