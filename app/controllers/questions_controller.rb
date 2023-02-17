class QuestionsController < ApplicationController
  before_action :set_question, only: %i[update show destroy edit hide]

  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to question_path(@question), notice: 'Новый вопрос создан!'
    else
      flash[:alert] = 'При создании вопроса возникли ошибки'
      flash[:question_errors] = @question.errors.full_messages

      redirect_to new_question_path
    end
  end

  def update
    @question = Question.find(params[:id])

    if @question.update(question_params)
      redirect_to root_path, notice: 'Вы успешно изменили данные'
    else
      flash[:alert] = 'При попытке изменить данные возникли ошибки'
      flash[:question_errors] = @question.errors.full_messages

      redirect_to edit_question_path(@question)
    end
  end

  def destroy
    @question.destroy

    redirect_to questions_path, notice: 'Вопрос удален!'
  end

  def show
  end

  def edit
  end

  def index
    @question = Question.new

    @questions = Question.order(:id).all
  end

  def new
    @question = Question.new
  end

  def hide
    @question.update(hidden: true)

    redirect_to questions_path
  end

  private

  def question_params
    params.require(:question).permit(:body, :user_id)
  end

  def set_question
    @question = Question.find(params[:id])
  end
end
