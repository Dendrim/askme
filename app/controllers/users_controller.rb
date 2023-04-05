class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destoy reset_color]
  before_action :authorize_user, only: %i[edit update destoy reset_color]

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
    redirect_with_alert unless current_user == @user

    if @user.update(user_params)
      redirect_to root_path, notice: 'Вы успешно изменили данные'
    else
      flash[:alert] = 'Вы неправильно заполнили поля формы регистрации'
      flash[:user_errors] = @user.errors.full_messages

      redirect_to edit_user_path
    end
  end

  def destroy
    redirect_with_alert unless current_user == @user

    @user.destroy
    session.delete(:user_id)

    redirect_to root_path, notice: 'Пользователь был успешно удален'
  end

  def show
    @user = User.find(params[:id])
    @questions = @user.questions.order('created_at DESC')
    @question = Question.new(user: @user)
  end

  def reset_color
    if @user.id == session[:user_id]
      @user.set_default_navbar_color
      flash[:notice] = 'Цвет успешно сброшен'
    end

    redirect_to edit_user_path(@user)
  end

  private

  def authorize_user
    redirect_with_alert unless current_user == @user
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :nickname, :email, :password, :password_confirmation, :color)
  end
end
