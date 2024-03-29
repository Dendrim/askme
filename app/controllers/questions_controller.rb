class QuestionsController < ApplicationController
  before_action :ensure_current_user, only: %i[update destroy edit hide]
  before_action :set_question_for_current_user, only: %i[update destroy edit hide]
  before_action :set_user, only: %i[new]

  def create # rubocop:disable Metrics/AbcSize
    question_params = params.require(:question).permit(:body, :user_id)
    @question = Question.new(question_params)
    @question.author = current_user

    if @question.save
      redirect_to user_path(@question.user.nickname), notice: 'Новый вопрос создан!'
    else
      flash[:alert] = 'При создании вопроса возникли ошибки'
      flash[:question_errors] = @question.errors.full_messages

      redirect_to new_question_path(nickname: @question.user.nickname)
    end
  end

  def update
    question_params = params.require(:question).permit(:body, :answer)

    if @question.update(question_params)
      redirect_to user_path(@question.user.nickname), notice: 'Вы успешно изменили данные'
    else
      flash[:alert] = 'При попытке изменить данные возникли ошибки'
      flash[:question_errors] = @question.errors.full_messages

      redirect_to edit_question_path(@question)
    end
  end

  def destroy
    @user = @question.user
    @question.destroy

    redirect_to user_path(@question.user.nickname), notice: 'Вопрос удален!'
  end

  def show
    @question = Question.find(params[:id])
  end

  def edit
  end

  def index
    @users = User.order(created_at: :desc).first(10)
    @questions = Question.includes(:user, :author, :hashtags).order(created_at: :desc).first(10)
    @hashtags = Hashtag.with_questions
  end

  def new
    @question = @user.questions.build
  end

  def hide
    @question.update(hidden: true)

    redirect_to user_path(@question.user.nickname), notice: 'Вопрос скрыт!'
  end

  private

  def set_user
    @user = User.where(nickname: params[:nickname])[0]
  end

  def ensure_current_user
    redirect_with_alert unless current_user.present?
  end

  def set_question_for_current_user
    @question = current_user.questions.find(params[:id])
  end
end
